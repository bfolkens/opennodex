defmodule OpenNodex do
  @moduledoc """
  Documentation for OpenNodex.
  """

  alias OpenNodex.{Charge, Client, Parser}

  @doc """
  Create a charge.  If currency is nil or create_charge/4 is called instead, Satoshis will be used.

  ## Examples

      iex> callback_url = "https://example.com/callback"
      iex> success_url = "https://example.com/success"
      iex> OpenNodex.Client.new("api_key")
      ...> |> OpenNodex.create_charge(99.01, "USD", callback_url, success_url)
      {:ok, %OpenNodex.Charge{callback_url: nil, name: nil, notif_email: nil, amount: 2573293, auto_settle: false, chain_invoice: %OpenNodex.Charge.ChainInvoice{address: "3btcaddress", settled_at: nil}, created_at: 1546732008, currency: "USD", description: "N/A", fiat_value: 99, id: "abbacadabba-d123-456a-baba-99bfdcfb16a1", lightning_invoice: %OpenNodex.Charge.LightningInvoice{created_at: 1546732009, expires_at: 1546735609, payreq: "lnbcsomelonginvoicestring", settled_at: nil}, notes: "", order_id: "N/A", source_fiat_value: 99, status: "unpaid", success_url: "https://site.com/order/abc123"}}

  """
  def create_charge(%Client{} = client, amount, callback_url, success_url), do:
    create_charge(client, amount, nil, callback_url, success_url)

  def create_charge(%Client{} = client, amount, base_currency, callback_url, success_url) do
    params = %{
      amount: amount,
      callback_url: callback_url,
      success_url: success_url
    }

    params =
      if base_currency != nil do
        Map.put(params, currency: base_currency)
      else
        params
      end

    request_body = Jason.encode!(params)

    case post(client, "charges", request_body) do
      {:ok, data} ->
        charge =
          data
          |> Parser.parse_atomized_keys()
          |> Charge.from()
        {:ok, charge}
      {:error, message} ->
        {:error, message}
    end
  end

  @doc """
  Get charges.

  ## Examples

      iex> OpenNodex.Client.new("api_key")
      ...> |> OpenNodex.get_charges()
      {:ok, [%OpenNodex.Charge{callback_url: nil, name: nil, notif_email: nil, amount: 2573293, auto_settle: false, chain_invoice: %OpenNodex.Charge.ChainInvoice{address: "3btcaddress", settled_at: nil}, created_at: 1546732008, currency: "USD", description: "N/A", fiat_value: 99, id: "abbacadabba-d123-456a-baba-99bfdcfb16a1", lightning_invoice: %OpenNodex.Charge.LightningInvoice{created_at: 1546732009, expires_at: 1546735609, payreq: "lnbcsomelonginvoicestring", settled_at: nil}, notes: "", order_id: "N/A", source_fiat_value: 99, status: "unpaid", success_url: "https://site.com/order/abc123"}]}

  """
  def get_charges(%Client{} = client) do
    case get(client, "charges") do
      {:ok, data} ->
        charges =
          data
          |> Parser.parse_atomized_keys()
          |> Enum.map(&Charge.from/1)
        {:ok, charges}
      {:error, message} ->
        {:error, message}
    end
  end

  @doc """
  Get a specific charge.

  ## Examples

      iex> OpenNodex.Client.new("api_key")
      ...> |> OpenNodex.get_charge("abbacadabba-d123-456a-baba-99bfdcfb16a1")
      {:ok, %OpenNodex.Charge{callback_url: nil, name: nil, notif_email: nil, amount: 2573293, auto_settle: false, chain_invoice: %OpenNodex.Charge.ChainInvoice{address: "3btcaddress", settled_at: nil}, created_at: 1546732008, currency: "USD", description: "N/A", fiat_value: 99, id: "abbacadabba-d123-456a-baba-99bfdcfb16a1", lightning_invoice: %OpenNodex.Charge.LightningInvoice{created_at: 1546732009, expires_at: 1546735609, payreq: "lnbcsomelonginvoicestring", settled_at: nil}, notes: "", order_id: "N/A", source_fiat_value: 99, status: "unpaid", success_url: "https://site.com/order/abc123"}}

  """
  def get_charge(%Client{} = client, id) do
    case get(client, "charge/#{id}") do
      {:ok, data} ->
        charge =
          data
          |> Parser.parse_atomized_keys()
          |> Charge.from()
        {:ok, charge}
      {:error, message} ->
        {:error, message}
    end
  end

  @doc """
  Retrieve the available currencies.

  ## Examples

      iex> OpenNodex.Client.new("api_key")
      ...> |> OpenNodex.get_currencies()
      {:ok, ["USD", "EUR", "RUB", "HKD", "CAD"]}

  """
  def get_currencies(%Client{} = client) do
    case get(client, "currencies") do
      {:ok, data} ->
        currencies = Parser.parse_string_keys(data)
        {:ok, currencies}
      {:error, message} ->
        {:error, message}
    end
  end

  @doc """
  Retrieve the exchange rates.

  ## Examples

      iex> OpenNodex.Client.new("api_key")
      ...> |> OpenNodex.get_rates()
      {:ok, %{"BTCUSD" => %{"USD" => 3845.30}, "BTCEUR" => %{"EUR" => 2890.95}}}

  """
  def get_rates(%Client{} = client) do
    case get(client, "rates") do
      {:ok, data} ->
        rates = Parser.parse_string_keys(data)
        {:ok, rates}
      {:error, message} ->
        {:error, message}
    end
  end

  #
  # Private
  #

  defp get(%Client{} = client, endpoint) do
    case request().get(client, endpoint) do
      %HTTPotion.Response{body: body, status_code: 200} ->
        {:ok, body}
      %HTTPotion.Response{body: body} ->
        {:error, Parser.parse_error(body)}
      %HTTPotion.ErrorResponse{message: body} ->
        {:error, body}
    end
  end

  defp post(%Client{} = client, endpoint, data) do
    case request().post(client, endpoint, data) do
      %HTTPotion.Response{body: body, status_code: 201} ->
        {:ok, body}
      %HTTPotion.Response{body: body} ->
        {:error, Parser.parse_error(body)}
      %HTTPotion.ErrorResponse{message: body} ->
        {:error, body}
    end
  end

  defp request, do: Application.get_env(:opennodex, :request, OpenNodex.Request)
end
