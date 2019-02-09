defmodule OpenNodex.Event do
  @moduledoc """
  Documentation for OpenNodex.Event.
  """

  defstruct [
    :id,
    :callback_url,
    :success_url,
    :status,
    :order_id,
    :description,
    :price,
    :fee,
    :auto_settle,
    :hashed_order
  ]

  @doc """
  Convenience method to convert a map to an `%Event{}`.
  """
  def from(%{} = m), do: struct(__MODULE__, m)

  @doc """
  Checks the validity of the order hash for the `event` and `api_key`.

  ## Examples

      iex> event = %OpenNodex.Event{
      ...>   id: "abbacadabba-d123-456a-baba-99bfdcfb16a1",
      ...>   hashed_order: "df873d17dd8b6335db232ed1c242d4df91b0dbe3b3f2baba67e7d38c43b8370c"
      ...> }
      iex> OpenNodex.Event.check_validity(event, "abbacadabba")
      true

  """
  def check_validity(event, api_key) do
    event.hashed_order == order_hash(event, api_key)
  end

  @doc """
  Computes the order hash (in base 16) for the `event` and `api_key`.

  ## Examples

      iex> event = %OpenNodex.Event{id: "abbacadabba-d123-456a-baba-99bfdcfb16a1"}
      iex> OpenNodex.Event.order_hash(event, "abbacadabba")
      "df873d17dd8b6335db232ed1c242d4df91b0dbe3b3f2baba67e7d38c43b8370c"

  """
  def order_hash(event, api_key) do
    :crypto.hmac(:sha256, api_key, event.id) |> Base.encode16(case: :lower)
  end
end
