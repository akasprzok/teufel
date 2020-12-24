defmodule Teufel.Attack do
  defstruct damages: %{}

  @type t :: %__MODULE__{
    damages: %{}
  }

  defimpl Enumerable do
    alias Teufel.Attack
    def count(%Attack{damages: damages}) do
      {:ok, Enum.count(damages)}
    end

    def member?(%Attack{damages: damages}, item) do
      {:ok, Enum.member?(damages, item)}
    end

     def reduce(_, {:halt, acc}, _fun), do: {:halted, acc}

    def reduce(%Attack{damages: damages}, {:suspend, acc}, fun) do
      {:suspended, acc, &reduce(%Attack{damages: damages}, &1, fun)}
    end

    def reduce(%Attack{damages: []}, {:cont, acc}, _fun), do: {:done, acc}

    def reduce(%Attack{damages: [head | tail]}, {:cont, acc}, fun) do
      reduce(%Attack{damages: tail}, fun.(head, acc), fun)
    end
  end
end
