defmodule OpenNodex.Client do
  @moduledoc """
  Configuration struct for the OpenNodex client.
  """

  defstruct api_key: nil, base_url: "https://api.opennode.co"

  @doc """
  Creates a new OpenNodex client with `api_key` (created on the opennode.co
  console) and either the default base url, or a specified `base_url`.

  ## Examples

      iex> OpenNodex.Client.new("test-key")
      %OpenNodex.Client{api_key: "test-key", base_url: "https://api.opennode.co"}
  """
  def new(api_key), do: %__MODULE__{api_key: api_key}
  def new(api_key, base_url), do: %__MODULE__{api_key: api_key, base_url: base_url}
end
