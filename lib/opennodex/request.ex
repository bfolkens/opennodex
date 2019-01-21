defmodule OpenNodex.Request do
  @moduledoc """
  Documentation for OpenNodex.Request.
  """

  alias OpenNodex.Client

  @api_version "v1"

  def get(%Client{api_key: api_key, base_url: base_url}, endpoint) do
    base_url
    |> url(endpoint)
    |> HTTPotion.get(headers: headers(api_key))
  end

  def post(%Client{api_key: api_key, base_url: base_url}, endpoint, body) do
    base_url
    |> url(endpoint)
    |> HTTPotion.post(body: body, headers: headers(api_key))
  end

  def url(base_url, endpoint), do: Enum.join([base_url, @api_version, endpoint], "/")

  def headers(api_key) do
    %{
      "Content-Type": "application/json",
      "User-Agent": user_agent(),
      Authorization: api_key
    }
  end

  def user_agent do
    "opennodex/#{version()}"
  end

  def version do
    Application.spec(:opennodex, :vsn)
  end
end
