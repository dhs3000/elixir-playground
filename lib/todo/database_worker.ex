defmodule Todo.DatabaseWorker do
  use GenServer

  def init(db_folder) do
    IO.puts("Starting database worker")
    {:ok, db_folder}
  end

  def handle_cast({:store, key, data}, db_folder) do
    file_name(db_folder, key)
      |> File.write!(:erlang.term_to_binary(data))
    {:noreply, db_folder}
  end

  def handle_call({:get, key}, _, db_folder) do
    data = case File.read(file_name(db_folder, key)) do
      {:ok, contents} -> :erlang.binary_to_term(contents)
      _ -> nil
    end
    {:reply, data, db_folder}
  end

  defp file_name(folder, file), do: "#{folder}/#{file}"

  def start_link(db_folder, worker_id) do
    IO.puts("Going to start database worker #{worker_id}")
    GenServer.start_link(__MODULE__, db_folder, name: workerName(worker_id))
  end

  def store(worker_id, key, data) do
    GenServer.cast(workerName(worker_id), {:store, key, data})
  end

  def get(worker_id, key) do
    GenServer.call(workerName(worker_id), {:get, key})
  end

  defp workerName(worker_id), do: :"database_worker_#{worker_id}"
end