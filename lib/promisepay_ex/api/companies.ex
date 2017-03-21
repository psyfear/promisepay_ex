defmodule PromisepayEx.API.Companies do
  @moduledoc """
  Provides companies API interfaces.
  """

  import PromisepayEx.API.Base
  alias PromisepayEx.Parser

  def companies do
    companies([])
  end

  @spec companies(Keyword.t) :: Keyword.t
  def companies(options) do
    params = Parser.parse_request_params(options)
    %{companies: company_results} = request(:get, "companies/", params)
    Enum.map(company_results, &Parser.parse_company/1)
  end

  @spec company(String.t) :: PromisepayEx.Model.Company.t
  def company(id) do
    %{companies: company} = request(:get, "/companies/#{id}", [])
    Parser.parse_company(company)
  end

  @spec create_company(Keyword.t) :: Keyword.t
  def create_company(options) do
    params = Parser.parse_request_params(options)
    %{companies: company} = request(:post, "companies", params)
    Parser.parse_company(company)
  end

  @spec update_company(Keyword.t) :: Keyword.t
  def update_company(options) do
    params = Parser.parse_request_params(options)
    url = "companies/" <> options[:id]
    %{companies: company} = request(:patch, url, params)
    Parser.parse_company(company)
  end
end
