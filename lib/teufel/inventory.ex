defmodule Teufel.Inventory do
  defstruct items: []

  defimpl Enumerable do
    alias Teufel.Inventory
    def count(%Inventory{items: items}) do
      {:ok, Enum.count(items)}
    end

    def member?(%Inventory{items: items}, item) do
      {:ok, Enum.member?(items, item)}
    end

     def reduce(_, {:halt, acc}, _fun), do: {:halted, acc}

    def reduce(%Inventory{items: items}, {:suspend, acc}, fun) do
      {:suspended, acc, &reduce(%Inventory{items: items}, &1, fun)}
    end

    def reduce(%Inventory{items: []}, {:cont, acc}, _fun), do: {:done, acc}

    def reduce(%Inventory{items: [head | tail]}, {:cont, acc}, fun) do
      reduce(%Inventory{items: tail}, fun.(head, acc), fun)
    end
  end
end
