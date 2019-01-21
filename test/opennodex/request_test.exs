defmodule OpenNodex.RequestTest do
  use ExUnit.Case
  alias OpenNodex.Request

  test "should build a url" do
    url = Request.url("https://api.opennodex.co", "charges")
    assert url == "https://api.opennodex.co/v1/charges"
  end
end
