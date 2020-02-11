defmodule OpenNodex.RequestTest do
  use ExUnit.Case
  alias OpenNodex.Request
  doctest OpenNodex.Request

  test "should build a url" do
    url = Request.url("https://api.opennodex.co", "v1", "charges")
    assert url == "https://api.opennodex.co/v1/charges"
  end

  test "should build headers" do
    headers = Request.headers("api-key")
    assert %{Authorization: "api-key", "Content-Type": _, "User-Agent": _} = headers
  end

  test "should return user agent" do
    user_agent = Request.user_agent()
    assert String.match?(user_agent, ~r{^opennodex/[\d\.]+$})
  end
end
