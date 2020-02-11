defmodule OpenNodex.Withdrawal do
  @moduledoc """
  Documentation for OpenNodex.Withdrawal.
  """

  defstruct [
    :id,
    :type,
    :amount,
    :reference,
    :fee,
    :status,
    :processed_at
  ]

  @doc """
  Convenience method to convert a map to a `%Withdrawal{}`.
  """
  def from(nil), do: nil
  def from(%{} = m), do: struct(__MODULE__, m)
end
