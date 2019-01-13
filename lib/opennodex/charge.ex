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
  def from(m = %{}) do
    struct(__MODULE__, %{
      m |
      lightning_invoice: LightningInvoice.from(m[:lightning_invoice]),
      chain_invoice: ChainInvoice.from(m[:chain_invoice])
    })
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
  def from(m = %{}), do: struct(__MODULE__, m)
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
  def from(m = %{}), do: struct(__MODULE__, m)
end
