defmodule OpenNodex.MockRequest do
  @moduledoc """
  OpenNodex.MockRequest can be used interchangeably with `OpenNodex.Request` in
  order to test request behavior.
  """

  def get(_, "rates") do
    body = ~s({"data":{"BTCUSD":{"USD":3845.30},"BTCEUR":{"EUR":2890.95}}})
    %HTTPotion.Response{status_code: 200, body: body}
  end

  def get(_, "currencies") do
    body = ~s({"data":["USD","EUR","RUB","HKD","CAD"]})
    %HTTPotion.Response{status_code: 200, body: body}
  end

  def get(_, "charges") do
    body = ~s"""
    {"data":[{"id":"abbacadabba-d123-456a-baba-99bfdcfb16a1","description":"N/A","amount":2573293,"status":"unpaid","fiat_value":99,"source_fiat_value":99,"currency":"USD","created_at":1546732008,"order_id":"N/A","success_url":"https://site.com/order/abc123","notes":"","auto_settle":false,"lightning_invoice":{"created_at":1546732009,"expires_at":1546735609,"payreq":"lnbcsomelonginvoicestring","settled_at":null},"chain_invoice":{"address":"3btcaddress","settled_at":null}}]}
    """

    %HTTPotion.Response{status_code: 200, body: body}
  end

  def get(_, "charge/abbacadabba-d123-456a-baba-99bfdcfb16a1") do
    body = ~s"""
    {"data":{"id":"abbacadabba-d123-456a-baba-99bfdcfb16a1","description":"N/A","amount":2573293,"status":"unpaid","fiat_value":99,"source_fiat_value":99,"currency":"USD","created_at":1546732008,"order_id":"N/A","success_url":"https://site.com/order/abc123","notes":"","auto_settle":false,"lightning_invoice":{"created_at":1546732009,"expires_at":1546735609,"payreq":"lnbcsomelonginvoicestring","settled_at":null},"chain_invoice":{"address":"3btcaddress","settled_at":null}}}
    """

    %HTTPotion.Response{status_code: 200, body: body}
  end

  def get(_, "charge/" <> _) do
    body = ~s"""
    {"success":false,"message":"Invoice does not exist."}
    """

    %HTTPotion.Response{status_code: 404, body: body}
  end

  def get(_, "api-key-error") do
    body = ~s"""
    {"success":false,"message":"Not authorized: missing api-key"}
    """

    %HTTPotion.Response{status_code: 401, body: body}
  end

  def post(_, "charges", _) do
    body = ~s"""
    {"data":{"id":"abbacadabba-d123-456a-baba-99bfdcfb16a1","description":"N/A","amount":2573293,"status":"unpaid","fiat_value":99,"source_fiat_value":99,"currency":"USD","created_at":1546732008,"order_id":"N/A","success_url":"https://site.com/order/abc123","notes":"","auto_settle":false,"lightning_invoice":{"created_at":1546732009,"expires_at":1546735609,"payreq":"lnbcsomelonginvoicestring","settled_at":null},"chain_invoice":{"address":"3btcaddress","settled_at":null}}}
    """

    %HTTPotion.Response{status_code: 201, body: body}
  end
end
