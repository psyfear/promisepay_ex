ExUnit.configure(
  formatters: [
    JUnitFormatter,
    ExUnit.CLIFormatter,
    ExUnitNotifier,
  ]
)

ExUnit.start()

Code.require_file("support/api_case.exs", "test")
