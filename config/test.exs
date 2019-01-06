use Mix.Config

config :opennodex,
  request: OpenNodex.MockRequest,
  api_key: "api_key"

config :junit_formatter,
    report_dir: "/tmp/repo-example-test-results/exunit"
