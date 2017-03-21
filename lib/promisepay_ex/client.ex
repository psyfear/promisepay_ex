defmodule PromisepayEx.Client do
  @moduledoc """
  Provide a wrapper for promisepay request methods.
  """

  @doc """
  Send request with get method.
  """
  @spec request(Keyword.t, String.t, Keyword.t, String.t, String.t) :: Map.t
  def request(method, url, params, username, password) do
    case method do
      :get ->
        perform_get(url, params, username, password)
      :post ->
        perform_post(url, params, username, password)
      _ ->
        # TODO
    end
  end

  def perform_get(_url, _params, nil, nil) do
    raise(PromisepayEx.Error, message: "Error")
  end

  @spec perform_get(String.t, Keyword.t, String.t, String.t) :: Map.t
  def perform_get(url, params, username, password) do
    params
    |> URI.encode_query
    |> build_params(url)
    |> send_request(username, password)
  end

  defp build_basic_auth(nil, nil), do: []

  defp build_basic_auth(username, password) do
    [
      hackney: [
        basic_auth: {
          username,
          password,
        }
      ]
    ]
  end

  defp send_request(request, username, password) do
    options = build_basic_auth(username, password)
    response = HTTPoison.get(request, [], options)

    case response do
      {
        :ok,
        %HTTPoison.Response{
          status_code: 200,
          body: body,
          headers: headers}
        } ->
        {:ok, {200, headers, body}}
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        {:error, "Not Found"}
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end

  defp build_params(params, url) do
    to_char_list(url <> "?" <> params)
  end

  def perform_post(_url, _params, nil, nil) do
    raise(PromisepayEx.Error, message: "Error")
  end

  @spec perform_post(String.t, Keyword.t, String.t, String.t) :: Map.t
  def perform_post(url, params, username, password) do
    params
    |> URI.encode_query
    |> build_params(url)
    |> send_post_request(username, password)
  end

  defp send_post_request(request, username, password) do
    headers = build_authorization_header(username, password)
    response = HTTPoison.post(request, "", headers)

    case response do
      {
        :ok,
        %HTTPoison.Response{
          status_code: 200,
          body: body,
          headers: headers
        }
      } ->
        {:ok, {200, headers, body}}
      {
        :ok,
        %HTTPoison.Response{
          status_code: 401,
          body: errors,
          headers: headers
        }
      } ->
        {:ok, {401, headers, errors}}



      {
        :ok,
        %HTTPoison.Response{
          status_code: 422,
          body: errors,
          headers: headers
        }
      } ->
        {:ok, {422, headers, errors}}



      {
        :ok,
        %HTTPoison.Response{
          status_code: 201,
          body: body,
          headers: headers
        }
      } ->
        {:ok, {201, headers, body}}
      {:ok, %HTTPoison.Response{status_code: 422}} ->
        {:error, "Not Found"}
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end

  defp build_authorization_header(username, password) do
    header = "Basic " <> Base.encode64(username <> ":" <> password)
    [{"Authorization", header}]
  end
end
