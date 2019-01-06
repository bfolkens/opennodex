defmodule OpenNodex.Parser do
  @moduledoc """
  Documentation for OpenNodex.Parser.
  """

  def parse_string_keys(json) do
    %{"data" => data} = Jason.decode!(json)
    data
  end

  def parse_atomized_keys(json) do
    %{data: data} = Jason.decode!(json, keys: :atoms!)
    data
  end
end