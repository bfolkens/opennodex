defmodule OpenNodex.Request do
  @moduledoc """
  Documentation for OpenNodex.Request.
  """

  @base_url "https://api.opennode.co/v1"

  def get(endpoint), do: HTTPotion.get(@base_url <> "/" <> endpoint)
  def post(endpoint, body), do: HTTPotion.post(@base_url <> "/" <> endpoint, body: body, headers: headers())

  def headers do
    %{
      "Content-Type": "application/json",
      "User-Agent": user_agent(),
      Authorization: auth_key()
    }
  end

  def user_agent do
    "opennodex/#{version()}"
  end

  def auth_key do
    Application.get_env(:opennodex, :api_key)
  end

  def version do
    Application.spec(:opennodex, :vsn)
  end
end
