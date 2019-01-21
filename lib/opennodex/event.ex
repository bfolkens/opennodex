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
  Checks the validity of the order hash for the `charge` and `api_key`.

    ## Examples

        iex> charge = %OpenNodex.Charge{
        ...>   id: "abbacadabba-d123-456a-baba-99bfdcfb16a1",
        ...>   hashed_order: "df873d17dd8b6335db232ed1c242d4df91b0dbe3b3f2baba67e7d38c43b8370c"
        ...> }
        iex> OpenNodex.Charge.check_validity(charge, "abbacadabba")
        true

  """
  def check_validity(charge, api_key) do
    charge.hashed_order == order_hash(charge, api_key)
  end

  @doc """
  Computes the order hash (in base 16) for the `charge` and `api_key`.

  ## Examples

      iex> charge = %OpenNodex.Charge{id: "abbacadabba-d123-456a-baba-99bfdcfb16a1"}
      iex> OpenNodex.Charge.order_hash(charge, "abbacadabba")
      "df873d17dd8b6335db232ed1c242d4df91b0dbe3b3f2baba67e7d38c43b8370c"

  """
  def order_hash(charge, api_key) do
    :crypto.hmac(:sha256, api_key, charge.id) |> Base.encode16(case: :lower)
  end
end
