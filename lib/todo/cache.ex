defmodule Todo.Cache do
  use GenServer

  def init(_) do
    IO.puts("Starting todo cache")
    {:ok, nil}
  end

  def handle_call({:server_process, todo_list_name}, _, state) do
    server = case Todo.Server.whereis(todo_list_name) do
      nil ->
        {:ok, pid} = Todo.ServerSupervisor.start_child(todo_list_name)
        pid
      s -> s
    end
    {:reply, server, state}
  end

  def start_link do
    GenServer.start_link(__MODULE__, nil, name: :todo_cache)
  end

  def server_process(todo_list_name) do
    Todo.Server.whereis(todo_list_name) || GenServer.call(:todo_cache, {:server_process, todo_list_name})
  end

end