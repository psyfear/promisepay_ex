defmodule PromisepayEx.Supervisor do
  @moduledoc """
  Supervisor
  """
  use Supervisor

  def start_link do
    :supervisor.start_link(__MODULE__, [])
  end

  @spec init([]) :: Map.t
  def init([]) do
    children = [
      # Define workers and child supervisors to be supervised
      # worker(PromisepayEx.Worker, [])
    ]

    # See http://elixir-lang.org/docs/stable/Supervisor.Behaviour.html
    # for other strategies and supported options
    supervise(children, strategy: :one_for_one)
  end
end
