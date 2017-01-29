defmodule PromisepayEx.API.Base do
  @moduledoc """
  Provides basic and common functionalities for Promisepay API.
  """

  @doc """
  Send request to the promisepay server specified by the configuration value api_domain.
  """
  def request(method, path, params \\ []) do
    perform_request(method, path, params)
  end

  defp perform_request(method, path, params) do
    config = PromisepayEx.Config.get_tuples |> verify_params
    url = request_url(path, config[:api_domain])
    response = PromisepayEx.Client.request(
      method, 
      url, 
      params,
      config[:token],
      config[:api_domain]
    )
    case response do
      {:error, reason} -> raise PromisepayEx.Error, message: reason
      r -> r |> parse_result
    end
  end

  def verify_params([]) do
    raise PromisepayEx.Error,
      message: "Auth parameters are not set. Use PromisepayEx.configure function to set parameters in advance."
  end

  def verify_params(params), do: params

  def request_url(path, api_domain) do
    "#{api_domain}/#{path}"
  end

  def parse_result(result) do
    {:ok, {_response, _header, body}} = result
    verify_response(PromisepayEx.JSON.decode!(body))
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
