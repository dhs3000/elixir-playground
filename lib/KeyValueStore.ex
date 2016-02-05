defmodule KeyValueStore do
  use GenServer

  def init(_), do: {:ok, HashDict.new}

  def handle_cast({:put, key, value}, state) do
    {:noreply, HashDict.put(state, key, value)}
  end

  def handle_call({:get, key}, _, state) do
    {:reply, HashDict.get(state, key), state}
  end

  def start, do: GenServer.start(__MODULE__, nil)

  def put(pid, key, value), do: GenServer.cast(pid, {:put, key, value})

  def get(pid, key), do: GenServer.call(pid, {:get, key})
end
