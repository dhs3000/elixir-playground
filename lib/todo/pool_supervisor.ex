defmodule Todo.PoolSupervisor do
  use Supervisor

  def start_link(db_folder, pool_size) do
    IO.puts("Gooing to start a pool with #{pool_size} workers")
    Supervisor.start_link(__MODULE__, {db_folder, pool_size})
  end

  def init({db_folder, pool_size}) do
    processes = for worker_id <- 1..pool_size do
      worker(Todo.DatabaseWorker, [db_folder, worker_id], id: :"pool_worker_#{worker_id}")
    end
    IO.puts("Starting pool with #{inspect processes}")
    supervise(processes, strategy: :one_for_one)
  end
end