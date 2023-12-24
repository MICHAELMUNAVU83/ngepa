defmodule Todos do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    {:ok, :ets.new(:todos, [:named_table, :public])}
  end

  def find(name) do
    case :ets.lookup(:todos, name) do
      [{^name, items}] -> {:ok, items}
      [] -> :error
    end
  end

  def new(name) do
    GenServer.call(__MODULE__, {:new, name})
  end

  def add(name, item) do
    GenServer.call(__MODULE__, {:add, name, item})
  end

  def delete(name) do
    GenServer.call(__MODULE__, {:delete, name})
  end

  def remove_from_list(name, item) do
    case find(name) do
      {:ok, items} ->
        items = List.delete(items, item)
        :ets.insert(:todos, {name, items})
        {:reply, items}

      :error ->
        {:reply, {:error, :list_not_found}}
    end
  end

  def handle_call({:remove_from_list, name, item}, _from, table) do
    case find(name) do
      {:ok, items} ->
        items = List.delete(items, item)
        :ets.insert(table, {name, items})
        {:reply, items, table}

      :error ->
        {:reply, {:error, :list_not_found}, table}
    end
  end

  def handle_call({:new, name}, _from, table) do
    case find(name) do
      {:ok, name} ->
        {:reply, name, table}

      :error ->
        :ets.insert(table, {name, []})
        {:reply, [], table}
    end
  end

  def handle_call({:add, name, item}, _from, table) do
    case find(name) do
      {:ok, items} ->
        items = [item | items]
        :ets.insert(table, {name, items})
        {:reply, items, table}

      :error ->
        {:reply, {:error, :list_not_found}, table}
    end
  end

  def handle_call({:delete, name}, _from, table) do
    case find(name) do
      {:ok, items} ->
        :ets.delete(table, name)
        {:reply, items, table}

      :error ->
        {:reply, {:error, :list_not_found}, table}
    end
  end
end
