defmodule OpenNodex do
  @moduledoc """
  Documentation for OpenNodex.
  """

  alias OpenNodex.{Charge, Parser}

  @doc """
  Create a charge.

  ## Examples

      iex> callback_url = "https://example.com/callback"
      iex> success_url = "https://example.com/success"
      iex> OpenNodex.create_charge(99.01, "USD", callback_url, success_url)
      {:ok, %OpenNodex.Charge{callback_url: nil, name: nil, notif_email: nil, amount: 2573293, auto_settle: false, chain_invoice: %OpenNodex.Charge.ChainInvoice{address: "3btcaddress", settled_at: nil}, created_at: 1546732008, currency: "USD", description: "N/A", fiat_value: 99, id: "abbacadabba-d123-456a-baba-99bfdcfb16a1", lightning_invoice: %OpenNodex.Charge.LightningInvoice{created_at: 1546732009, expires_at: 1546735609, payreq: "lnbcsomelonginvoicestring", settled_at: nil}, notes: "", order_id: "N/A", source_fiat_value: 99, status: "unpaid", success_url: "https://site.com/order/abc123"}}

  """
  def create_charge(amount, base_currency, callback_url, success_url) do
    request_body = Jason.encode!(%{
      amount: amount,
      currency: base_currency,
      callback_url: callback_url,
      success_url: success_url
    })

    case post("charges", request_body) do
      {:ok, data} ->
        charge =
          data
          |> Parser.parse_atomized_keys()
          |> Charge.from()
        {:ok, charge}
      response ->
        response
    end
  end

  @doc """
  Get charges.

  ## Examples

      iex> OpenNodex.get_charges()
      {:ok, [%OpenNodex.Charge{callback_url: nil, name: nil, notif_email: nil, amount: 2573293, auto_settle: false, chain_invoice: %OpenNodex.Charge.ChainInvoice{address: "3btcaddress", settled_at: nil}, created_at: 1546732008, currency: "USD", description: "N/A", fiat_value: 99, id: "abbacadabba-d123-456a-baba-99bfdcfb16a1", lightning_invoice: %OpenNodex.Charge.LightningInvoice{created_at: 1546732009, expires_at: 1546735609, payreq: "lnbcsomelonginvoicestring", settled_at: nil}, notes: "", order_id: "N/A", source_fiat_value: 99, status: "unpaid", success_url: "https://site.com/order/abc123"}]}

  """
  def get_charges do
    case get("charges") do
      {:ok, data} ->
        charges =
          data
          |> Parser.parse_atomized_keys()
          |> Enum.map(&Charge.from/1)
        {:ok, charges}
      response ->
        response
    end
  end

  @doc """
  Get a specific charge.

  ## Examples

      iex> OpenNodex.get_charge("abbacadabba-d123-456a-baba-99bfdcfb16a1")
      {:ok, %OpenNodex.Charge{callback_url: nil, name: nil, notif_email: nil, amount: 2573293, auto_settle: false, chain_invoice: %OpenNodex.Charge.ChainInvoice{address: "3btcaddress", settled_at: nil}, created_at: 1546732008, currency: "USD", description: "N/A", fiat_value: 99, id: "abbacadabba-d123-456a-baba-99bfdcfb16a1", lightning_invoice: %OpenNodex.Charge.LightningInvoice{created_at: 1546732009, expires_at: 1546735609, payreq: "lnbcsomelonginvoicestring", settled_at: nil}, notes: "", order_id: "N/A", source_fiat_value: 99, status: "unpaid", success_url: "https://site.com/order/abc123"}}

  """
  def get_charge(id) do
    case get("charge/#{id}") do
      {:ok, data} ->
        charge =
          data
          |> Parser.parse_atomized_keys()
          |> Charge.from()
        {:ok, charge}
      response ->
        response
    end
  end

  @doc """
  Retrieve the available currencies.

  ## Examples

      iex> OpenNodex.get_currencies()
      {:ok, ["USD", "EUR", "RUB", "HKD", "CAD"]}

  """
  def get_currencies do
    case get("currencies") do
      {:ok, data} ->
        currencies =
          data
          |> Parser.parse_string_keys()
        {:ok, currencies}
      response ->
        response
    end
  end

  @doc """
  Retrieve the exchange rates.

  ## Examples

      iex> OpenNodex.get_rates()
      {:ok, %{"BTCUSD" => %{"USD" => 3845.30}, "BTCEUR" => %{"EUR" => 2890.95}}}

  """
  def get_rates do
    case get("rates") do
      {:ok, data} ->
        rates =
          data
          |> Parser.parse_string_keys()
        {:ok, rates}
      response ->
        response
    end
  end

  #
  # Private
  #

  defp get(endpoint) do
    case request().get(endpoint) do
      %HTTPotion.Response{body: body, status_code: 200} ->
        {:ok, body}
      response ->
        {:error, response}
    end
  end

  defp post(endpoint, data) do
    case request().post(endpoint, data) do
      %HTTPotion.Response{body: body, status_code: 201} ->
        {:ok, body}
      response ->
        {:error, response}
    end
  end

  defp request, do: Application.get_env(:opennodex, :request, OpenNodex.Request)
end
