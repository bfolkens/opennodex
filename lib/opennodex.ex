defmodule OpenNodex do
  @moduledoc """
  Documentation for OpenNodex.
  """

  alias OpenNodex.{Charge, Client, Parser, Withdrawal}

  @doc """
  Create a charge.  If currency is omitted, Satoshis will be used.

  ## Examples

      iex> OpenNodex.Client.new("api_key")
      ...> |> OpenNodex.create_charge(99.01, %{currency: "USD"})
      {:ok, %OpenNodex.Charge{callback_url: nil, name: nil, notif_email: nil, amount: 2573293, auto_settle: false, chain_invoice: %OpenNodex.Charge.ChainInvoice{address: "3btcaddress", settled_at: nil}, created_at: 1546732008, currency: "USD", description: "N/A", fiat_value: 99, id: "abbacadabba-d123-456a-baba-99bfdcfb16a1", lightning_invoice: %OpenNodex.Charge.LightningInvoice{created_at: 1546732009, expires_at: 1546735609, payreq: "lnbcsomelonginvoicestring", settled_at: nil}, notes: "", order_id: "N/A", source_fiat_value: 99, status: "unpaid", success_url: "https://site.com/order/abc123"}}

  """
  def create_charge(%Client{} = client, amount, attrs \\ %{}) do
    request_body =
      attrs
      |> Map.put(:amount, amount)
      |> Jason.encode!()

    case post(client, "v1", "charges", request_body) do
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
    case get(client, "v1", "charges") do
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
    case get(client, "v1", "charge/#{id}") do
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
  Decode a BOLT11 compliant payment request.

  ## Examples

      iex> OpenNodex.Client.new("api_key")
      ...> |> OpenNodex.decode_charge("lnbc10n1p0pgxq3pp59t5yhacrkkqz9sy6p54d9lzgj7cydvj4k5ve3prd034ewphmqx2qdq8w3jhxaqcqzpg2fg0jy2svf3dxlqjwfugr8enrsqv9j4n78cch25w0sdjrw4a8ngqwyemr698kdqfk8d4uqvkt6p5436a4m83qvykaxzu7xpsrhq5u6sqm4l7p7")
      {:ok, %{"pay_req" => %{"network" => "bitcoin", "amount" => 1, "pub_key" => "03abf6f44c355dec0d5aa155bdbdd6e0c8fefe318eff402de65c6eb2e1be55dc3e", "hash" => "2ae84bf703b58022c09a0d2ad2fc4897b046b255b51998846d7c6b9706fb0194"}}}

  """
  def decode_charge(%Client{} = client, bolt_request) do
    case post(client, "v1", "charge/decode", %{"pay_req" => bolt_request}) do
      {:ok, data} ->
        pay_req =
          data
          |> Parser.parse_string_keys()

        {:ok, pay_req}

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
    case get(client, "v1", "currencies") do
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
    case get(client, "v1", "rates") do
      {:ok, data} ->
        rates = Parser.parse_string_keys(data)
        {:ok, rates}

      {:error, message} ->
        {:error, message}
    end
  end

  @doc """
  Retrieve the account balance.

  ## Examples

      iex> OpenNodex.Client.new("api_key")
      ...> |> OpenNodex.get_account_balance()
      {:ok, %{"balance" => %{"BTC" => 259928620, "USD" => 18545.86 }}}

  """
  def get_account_balance(%Client{} = client) do
    case get(client, "v1", "account/balance") do
      {:ok, data} ->
        account_balance = Parser.parse_string_keys(data)
        {:ok, account_balance}

      {:error, message} ->
        {:error, message}
    end
  end

  @doc """
  Initiate a withdrawal.

  ## Examples

      iex> OpenNodex.Client.new("api_key")
      ...> |> OpenNodex.initiate_withdrawal("ln", %{"amount" => 5000, "address" => "", "callback_url" => ""})
      {:ok, %OpenNodex.Withdrawal{id: "3f50999e-f21f-4981-b67c-ea9c075be7d6", amount: 10, fee: 0, processed_at: 1559559748, status: "pending", type: "ln", reference: "lntb100n1pw0fl34pp5p8u6alsp6vr7ngevp82lu6kz7j4ryla0dgpg9es0jq70shs39xzsdqqcqzpgxqyz5vqm5egyvdadnnvrecqdzamwl6guhhvkpja0s9e0vu6g0ay75kegzfnhjykdveagfj8rt9nay0yvu8j94shsvj3ghxu306y2pac02nq85qq7m8tsc", address: nil, fiat_value: nil}}

  """

  def initiate_withdrawal(%Client{} = client, type, attrs \\ %{}) do
    request_body =
      attrs
      |> Map.put(:type, type)
      |> Jason.encode!()

    case post(client, "v2", "withdrawals", request_body) do
      {:ok, data} ->
        withdrawal =
          data
          |> Parser.parse_atomized_keys()
          |> Withdrawal.from()

        {:ok, withdrawal}

      {:error, message} ->
        {:error, message}
    end
  end

  @doc """
  List the withdrawals.

  ## Examples

      iex> OpenNodex.Client.new("api_key")
      ...> |> OpenNodex.get_withdrawals()
      {:ok, [%OpenNodex.Withdrawal{fiat_value: nil, address: "03c856d2dbec7454c48f311031f06bb99e3ca1ab15a9b9b35de14e139aa663b463", amount: 10, fee: 0, id: "3f50999e-f21f-4981-b67c-ea9c075be7d6", processed_at: 1559559748, reference: "lntb100n1pw0fl34pp5p8u6alsp6vr7ngevp82lu6kz7j4ryla0dgpg9es0jq70shs39xzsdqqcqzpgxqyz5vqm5egyvdadnnvrecqdzamwl6guhhvkpja0s9e0vu6g0ay75kegzfnhjykdveagfj8rt9nay0yvu8j94shsvj3ghxu306y2pac02nq85qq7m8tsc", status: "confirmed", type: "ln"}, %OpenNodex.Withdrawal{address: "03c856d2dbec7454c48f311031f06bb99e3ca1ab15a9b9b35de14e139aa663b463", amount: 1, fee: 0, fiat_value: nil, id: "4652231a-2c0a-4134-9bb6-a7f3fb1b06a4", processed_at: 1558963969, reference: "lntb10n1pwwhehmpp5ypyq6t5gp4466xchks9s95hwwpm88hkfxez9qnpt4wc5qkpknj0sdqqcqzpgxqyz5vqptw4ljzupae9yad60crk84l9av76dt7s4rkxk3g22kwlax2uv5ryc4swf6dqfyrn5lhhu5r8f80cvlca4lxf3hrzwy4634kfc3z47nqpn6cuuq", status: "confirmed", type: "ln"}]}

  """

  def get_withdrawals(%Client{} = client) do
    case get(client, "v1", "withdrawals") do
      {:ok, data} ->
        withdrawals =
          data
          |> Parser.parse_atomized_keys()
          |> Enum.map(&Withdrawal.from/1)

        {:ok, withdrawals}

      {:error, message} ->
        {:error, message}
    end
  end

  @doc """
  Get a withdrawal.

  ## Examples

      iex> OpenNodex.Client.new("api_key")
      ...> |> OpenNodex.get_withdrawal("3f50999e-f21f-4981-b67c-ea9c075be7d6")
      {:ok, %OpenNodex.Withdrawal{fiat_value: nil, processed_at: nil, address: "03c856d2dbec7454c48f311031f06bb99e3ca1ab15a9b9b35de14e139aa663b463", amount: 10, fee: 0, id: "3f50999e-f21f-4981-b67c-ea9c075be7d6", reference: "lntb100n1pw0fl34pp5p8u6alsp6vr7ngevp82lu6kz7j4ryla0dgpg9es0jq70shs39xzsdqqcqzpgxqyz5vqm5egyvdadnnvrecqdzamwl6guhhvkpja0s9e0vu6g0ay75kegzfnhjykdveagfj8rt9nay0yvu8j94shsvj3ghxu306y2pac02nq85qq7m8tsc", status: "confirmed", type: "ln"}}
  """

  def get_withdrawal(%Client{} = client, id) do
    case get(client, "v1", "withdrawal/#{id}") do
      {:ok, data} ->
        withdrawal =
          data
          |> Parser.parse_atomized_keys()
          |> Withdrawal.from()

        {:ok, withdrawal}

      {:error, message} ->
        {:error, message}
    end
  end

  @doc """
  Retrieve the OpenNodex version.
  """

  def version do
    Application.spec(:opennodex, :vsn)
  end

  #
  # Private
  #

  defp get(%Client{} = client, api_version, endpoint) do
    case request().get(client, api_version, endpoint) do
      %HTTPotion.Response{body: body, status_code: 200} ->
        {:ok, body}

      %HTTPotion.Response{body: body} ->
        {:error, Parser.parse_error(body)}

      %HTTPotion.ErrorResponse{message: body} ->
        {:error, body}
    end
  end

  defp post(%Client{} = client, api_version, endpoint, data) do
    case request().post(client, api_version, endpoint, data) do
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
