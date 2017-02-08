defmodule PromisepayEx.Client do
  @moduledoc """
  Provide a wrapper for promisepay request methods.
  """

  @doc """
  Send request with get method.
  """
  @spec request(:get, String.t, Keyword.t, String.t, String.t) :: Map.t
  def request(:get, url, params, token, _environment) do
    perform_get(url, params, token, nil, [])
  end

  @spec perform_get(String.t, Keyword.t, String.t, String.t, Keyword.t) :: Map.t
  def perform_get(url, params, token, _environment, _options) do
    params
    |> URI.encode_query
    |> build_params(url)
    |> send_request(token)
  end
  
  defp send_request(request, token) do
    headers = ["Authorization": "Basic #{token}", "Accept": "Application/json; Charset=utf-8"]
    options = [ssl: [{:versions, [:'tlsv1.2']}]]
    response = HTTPoison.get(request, headers, options)
    case response do
      {:ok, %HTTPoison.Response{status_code: 200, body: body, headers: headers}} ->
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
end
