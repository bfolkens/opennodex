defmodule OpenNodex.Parser do
  @moduledoc """
  Documentation for OpenNodex.Parser.
  """

  @doc """
  Decode the return json from the API and extract the `data` key's value,
  retaining the keys as strings.

    ## Examples

        iex> parse_string_keys(~s({"data":{"BTCUSD":{"USD":3845.30}}}))
        %{"data" => %{"BTCUSD" => %{"USD" => 3845.30}}}

  """
  def parse_string_keys(json) do
    %{"data" => data} = Jason.decode!(json)
    data
  end

  @doc """
  Decode the return json from the API and extract the `data` key's value,
  converting the keys to atoms.

      ## Examples

          iex> parse_string_keys(~s({"data":{"BTCUSD":{"USD":3845.30}}}))
          %{data: %{BTCUSD: %{USD: 3845.30}}}

  """
  def parse_atomized_keys(json) do
    %{data: data} = Jason.decode!(json, keys: :atoms)
    data
  end

  @doc """
  Decode an error message from the API.

        ## Examples

            iex> parse_string_keys(~s({"message":"error message"})))
            "error message"

  """
  def parse_error(json) do
    %{"message" => message} = Jason.decode!(json)
    message
  end
end
