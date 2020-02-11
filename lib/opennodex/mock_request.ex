defmodule OpenNodex.MockRequest do
  @moduledoc """
  OpenNodex.MockRequest can be used interchangeably with `OpenNodex.Request` in
  order to test request behavior.
  """

  def get(_, "v1", "rates") do
    body = ~s({"data":{"BTCUSD":{"USD":3845.30},"BTCEUR":{"EUR":2890.95}}})
    %HTTPotion.Response{status_code: 200, body: body}
  end

  def get(_, "v1", "currencies") do
    body = ~s({"data":["USD","EUR","RUB","HKD","CAD"]})
    %HTTPotion.Response{status_code: 200, body: body}
  end

  def get(_, "v1", "charges") do
    body = ~s"""
    {"data":[{"id":"abbacadabba-d123-456a-baba-99bfdcfb16a1","description":"N/A","amount":2573293,"status":"unpaid","fiat_value":99,"source_fiat_value":99,"currency":"USD","created_at":1546732008,"order_id":"N/A","success_url":"https://site.com/order/abc123","notes":"","auto_settle":false,"lightning_invoice":{"created_at":1546732009,"expires_at":1546735609,"payreq":"lnbcsomelonginvoicestring","settled_at":null},"chain_invoice":{"address":"3btcaddress","settled_at":null}}]}
    """

    %HTTPotion.Response{status_code: 200, body: body}
  end

  def get(_, "v1", "account/balance") do
    body = ~s"""
    {"data":{"balance":{"BTC":259928620,"USD":18545.86}}}
    """

    %HTTPotion.Response{status_code: 200, body: body}
  end

  def get(_, "v1", "charge/abbacadabba-d123-456a-baba-99bfdcfb16a1") do
    body = ~s"""
    {"data":{"id":"abbacadabba-d123-456a-baba-99bfdcfb16a1","description":"N/A","amount":2573293,"status":"unpaid","fiat_value":99,"source_fiat_value":99,"currency":"USD","created_at":1546732008,"order_id":"N/A","success_url":"https://site.com/order/abc123","notes":"","auto_settle":false,"lightning_invoice":{"created_at":1546732009,"expires_at":1546735609,"payreq":"lnbcsomelonginvoicestring","settled_at":null},"chain_invoice":{"address":"3btcaddress","settled_at":null}}}
    """

    %HTTPotion.Response{status_code: 200, body: body}
  end

  def get(_, "v1", "charge/" <> _) do
    body = ~s"""
    {"success":false,"message":"Invoice does not exist."}
    """

    %HTTPotion.Response{status_code: 404, body: body}
  end

  def get(_, "v1", "api-key-error") do
    body = ~s"""
    {"success":false,"message":"Not authorized: missing api-key"}
    """

    %HTTPotion.Response{status_code: 401, body: body}
  end

  def post(_, "v1", "charges", _) do
    body = ~s"""
    {"data":{"id":"abbacadabba-d123-456a-baba-99bfdcfb16a1","description":"N/A","amount":2573293,"status":"unpaid","fiat_value":99,"source_fiat_value":99,"currency":"USD","created_at":1546732008,"order_id":"N/A","success_url":"https://site.com/order/abc123","notes":"","auto_settle":false,"lightning_invoice":{"created_at":1546732009,"expires_at":1546735609,"payreq":"lnbcsomelonginvoicestring","settled_at":null},"chain_invoice":{"address":"3btcaddress","settled_at":null}}}
    """

    %HTTPotion.Response{status_code: 201, body: body}
  end

  def post(_, "v1", "charge/decode", _) do
    body = ~s"""
    {"data":{"pay_req":{"network":"bitcoin","amount":1,"pub_key":"03abf6f44c355dec0d5aa155bdbdd6e0c8fefe318eff402de65c6eb2e1be55dc3e","hash":"2ae84bf703b58022c09a0d2ad2fc4897b046b255b51998846d7c6b9706fb0194"}}}
    """

    %HTTPotion.Response{status_code: 201, body: body}
  end

  def post(_, "v2", "withdrawals", _) do
    body = ~s"""
    {"data":{"id":"3f50999e-f21f-4981-b67c-ea9c075be7d6","type":"ln","amount":10,"reference":"lntb100n1pw0fl34pp5p8u6alsp6vr7ngevp82lu6kz7j4ryla0dgpg9es0jq70shs39xzsdqqcqzpgxqyz5vqm5egyvdadnnvrecqdzamwl6guhhvkpja0s9e0vu6g0ay75kegzfnhjykdveagfj8rt9nay0yvu8j94shsvj3ghxu306y2pac02nq85qq7m8tsc","fee":0,"status":"pending","processed_at":1559559748}}
    """

    %HTTPotion.Response{status_code: 201, body: body}
  end
end
