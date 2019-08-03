Bureaucrat.start(
  json_library: Jason,
  default_path: "docs/api.md",
  titles: [
    {ZxWeb.PartnerController, "API /partners"}
  ]

)
ExUnit.start(formatters: [ExUnit.CLIFormatter, Bureaucrat.Formatter])
Ecto.Adapters.SQL.Sandbox.mode(Zx.Repo, :manual)
