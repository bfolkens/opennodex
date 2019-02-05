defmodule OpenNodex.Charge do
  @moduledoc """
  Documentation for OpenNodex.Charge.
  """

  alias OpenNodex.Charge.{ChainInvoice, LightningInvoice}

  defstruct [
    :id,
    :name,
    :description,
    :created_at,
    :status,
    :callback_url,
    :success_url,
    :order_id,
    :notes,
    :currency,
    :source_fiat_value,
    :fiat_value,
    :auto_settle,
    :notif_email,
    :lightning_invoice,
    :chain_invoice,
    :amount
  ]

  @doc """
  Convenience method to convert a map to a `%Charge{}`.
  """
  def from(%{} = m) do
    merged =
      m
      |> Map.update(:lightning_invoice, nil, &LightningInvoice.from/1)
      |> Map.update(:chain_invoice, nil, &ChainInvoice.from/1)

    struct(__MODULE__, merged)
  end
end

defmodule OpenNodex.Charge.LightningInvoice do
  @moduledoc """
  Documentation for OpenNodex.Charge.LightningInvoice.
  """

  defstruct [
    :created_at,
    :expires_at,
    :settled_at,
    :payreq
  ]

  @doc """
  Convenience method to convert a map to a `%LightningInvoice{}`.
  """
  def from(nil), do: nil
  def from(%{} = m), do: struct(__MODULE__, m)
end

defmodule OpenNodex.Charge.ChainInvoice do
  @moduledoc """
  Documentation for OpenNodex.Charge.ChainInvoice.
  """

  defstruct [
    :address,
    :settled_at
  ]

  @doc """
  Convenience method to convert a map to a `%ChainInvoice{}`.
  """
  def from(nil), do: nil
  def from(%{} = m), do: struct(__MODULE__, m)
end
