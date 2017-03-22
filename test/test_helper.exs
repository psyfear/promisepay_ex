Code.require_file("api_case.exs", "test/support")

ExUnit.configure(
  formatters: [
    JUnitFormatter,
    ExUnit.CLIFormatter,
    ExUnitNotifier,
  ]
)

ExUnit.start()
