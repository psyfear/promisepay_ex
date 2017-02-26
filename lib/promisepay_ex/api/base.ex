defmodule PromisepayEx.API.Base do
  @moduledoc """
  Provides basic and common functionalities for Promisepay API.
  """

  alias PromisepayEx.JSON
  alias PromisepayEx.Config
  alias PromisepayEx.Client

  @doc """
  Send request to the promisepay server
  """
  @spec request(:get, String.t, Keyword.t) :: Map.t
  def request(method, path, params \\ []) do
    perform_request(method, path, params)
  end

  defp perform_request(method, path, params) do
    config = Config.get_tuples |> verify_params
    url = request_url(path, config[:api_domain])
    response = Client.request(
      method,
      url,
      params,
      config[:username],
      config[:password]
    )
    case response do
      {:error, reason} -> raise PromisepayEx.Error, message: reason
      r -> r |> parse_result
    end
  end

  @spec verify_params([]) :: Map.t
  def verify_params([]) do
    raise(
      PromisepayEx.Error,
      message: "Auth parameters are not set.",
    )
  end

  @spec verify_params(Map.t) :: Map.t
  def verify_params(params), do: params

  @spec request_url(String.t, String.t) :: String.t
  def request_url(path, api_domain) do
    "#{api_domain}/#{path}"
  end

  @spec parse_result(Map.t) :: Map.t
  def parse_result(result) do
    {:ok, {_response, _header, body}} = result
    verify_response(JSON.decode!(body))
  end

  defp verify_response(body) do
    if is_list(body) do
      body
    else
      case Map.get(body, :errors, nil) || Map.get(body, :error, nil) do
        nil ->
          body
        errors when is_list(errors) ->
          parse_error(List.first(errors))
        error ->
          raise(PromisepayEx.Error, message: inspect error)
      end
    end
  end

  defp parse_error(error) do
    %{:code => code, :message => message} = error
    case code do
      _  -> raise PromisepayEx.Error, code: code, message: message
    end
  end
end
