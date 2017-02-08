use Mix.Config

config :junit_formatter,
  report_file: "results.xml",
  print_report_file: true

config :mix_test_watch,
  tasks: [
    "credo",
    "test",
  ]
