defmodule OpenNodex.Parser do
  def parse_string_keys(json) do
    %{"data" => data} = Jason.decode!(json)
    data
  end

  def parse_atomized_keys(json) do
    %{data: data} = Jason.decode!(json, keys: :atoms!)
    data
  end
end
