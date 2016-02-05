defmodule Todo.Server do
  use GenServer

  # Public API

  def start_link(name, entries \\ []) do
    IO.puts("Going to start todo-list server for #{name}")
    GenServer.start_link(__MODULE__, {name, entries}, name: server_name(name))
  end

  def add_entry(server_pid, date, title) do
    add_entry(server_pid, Todo.Entry.new(date, title))
  end

  def add_entry(server_pid, %Todo.Entry{} = entry) do
    GenServer.cast(server_pid, {:add_entry, entry})
  end

  def entries(server_pid, {year, month, day}) do
    GenServer.call(server_pid, {:entries, {year, month, day}})
  end

  def entries(server_pid, {year, month}) do
    GenServer.call(server_pid, {:entries, {year, month}})
  end

  defp server_name(name), do: :"todo_list_server_#{name}"

  # GenServer API

  def whereis(name), do: server_name(name) |> Process.whereis

 def init({name, entries}) do
   IO.puts("Starting todo-list server for #{name}")
   {:ok, {name, Todo.Database.get(name) || Todo.List.new(entries)}}
 end

 def handle_cast({:add_entry, entry}, {name, todo_list}) do
  new_state = Todo.List.add_entry(todo_list, entry)
  Todo.Database.store(name, new_state)
  {:noreply, {name, new_state}}
 end

 def handle_call({:entries, date}, _, {name, todo_list}) do
  {:reply, Todo.List.entries(todo_list, date), {name, todo_list}}
 end

end