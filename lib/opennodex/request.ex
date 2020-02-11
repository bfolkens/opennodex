defmodule OpenNodex.Request do
  @moduledoc """
  Documentation for OpenNodex.Request.
  """

  alias OpenNodex.Client

  def get(%Client{} = client, api_version, endpoint) do
    client.base_url
    |> url(api_version, endpoint)
    |> HTTPotion.get(headers: headers(client.api_key))
  end

  def post(%Client{} = client, api_version, endpoint, body) do
    client.base_url
    |> url(api_version, endpoint)
    |> HTTPotion.post(body: body, headers: headers(client.api_key))
  end

  def url(base_url, api_version, endpoint), do: Enum.join([base_url, api_version, endpoint], "/")

  def headers(api_key) do
    %{
      "Content-Type": "application/json",
      "User-Agent": user_agent(),
      Authorization: api_key
    }
  end

  def user_agent do
    "opennodex/#{OpenNodex.version()}"
  end
end
