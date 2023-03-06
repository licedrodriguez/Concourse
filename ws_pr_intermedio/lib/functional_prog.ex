defmodule Basics.FunctionalProg do
  def example1() do
    numbers = [1, 2, 3]
    IO.inspect(numbers, label: "Example 1 - Numbers")

    comp = for num <- numbers, do: num * 3
    IO.inspect(comp, label: "Multiply by 3")

  end

  def example2() do
    symbols = %{"Iron" => "Fe", "Carbon" => "C"}
    #symbols2 = %{litium: %{weight: 3, initials: "Li"}, hydrogen: "H"}
    IO.inspect(symbols, label: "Example 2 - Symbols")

    keys = for {key, _value} <- symbols do
      key <> ", "
    end

    values = for {_key, value} <- symbols do
      value <> ", "
    end

    IO.puts("Keys and values by separate")
    IO.inspect(symbols, label: "Example 2 - Symbols updated")
    IO.puts(keys)
    IO.puts(values)
  end

  def example3 do
    amounts = [2, 3]
    sizes = ["cups", "spoonfuls"]
    items = ["elderflower", "pomfrey"]

    joins = for a <- amounts, s <- sizes, i <- items do
      "#{a} #{s} of #{i}\n"
    end
    IO.puts(joins)
  end

  def example4 do
    #With letters will work the same
    i = [5, 4, 8, 1, 2]
    IO.inspect(i, label: "Example 4 - Enums")

    i_sorted = Enum.sort(i)
    i_sorted_desc = Enum.sort(i, :desc)

    IO.puts("Sorted list")
    IO.inspect(i_sorted)
    IO.puts("Sorted list inversed")
    IO.inspect(i_sorted_desc)
  end

  def example5 do
    animals = ["le chat", "le chien", "le lapin", "le perroquet"]
    IO.inspect(animals, label: "Animals in french")

    #Iterate and prints each animal (a) in animals
    e = Enum.each(animals, fn(a) -> IO.puts(a) end)
    IO.inspect(e, label: "Animals after Enum.each")

    m1 = Enum.map(animals, fn(a) -> IO.puts(a) end)
    IO.inspect(m1, label: "Animals after map - puts")

    m2 = Enum.map(animals, fn(a) -> IO.inspect(a) end)
    IO.inspect(m2, label: "Animals after map - inspect")
  end

  def example6 do
    elements = [%{name: "Hydrogen", symbol: "H", number: 1},
    %{name: "Iron", symbol: "Fe", number: 26},
    %{name: "Carbon", symbol: "C", number: 6}]

    #Sort by symbol, asc
    bySymbol = Enum.sort_by(elements, fn(e) -> e.symbol end)
    IO.puts("Sorted by symbol - asc")
    IO.inspect(bySymbol)
    #Sort by number desc
    byNumber = Enum.sort_by(elements, fn(e) -> e.number end, :desc)
    IO.puts("Sorted by number - desc")
    IO.inspect(byNumber)

  end

  def example7() do

    numbers = [2, 3, 4]
    IO.inspect(numbers, label: "Numbers")
    r = Enum.reduce(numbers, 0, fn(n, acc) ->
      IO.inspect(acc, label: "Accumulator")
      IO.inspect(n, label: "Element")
      IO.inspect(n + acc, label: "Product")
    end)
    IO.inspect(r, label: "Reduce")

  end

  def example8() do
    elements=["Carbon","Hydrogen","Iron"]
    IO.inspect(elements, label: "Elements")

    #r = Enum.reduce(elements,"",fn(elem,acc) ->
    #    IO.inspect(acc, label: "Accumulator")
    #    IO.inspect(elem, label: "Element")
    #    IO.inspect(acc <> elem, label: "Product")
    #    end)

    r2 = Enum.reduce(elements,[],fn(elem,acc) ->
        IO.inspect(acc, label: "Accumulator")
        IO.inspect(elem, label: "Element")
        IO.inspect([String.downcase(elem) | acc], label: "Product")
        end)
    IO.inspect(r2, label: "Result")
  end

  def example9() do
   elements= [
        %{name: "Hydrogen", number: 1, weight: 1},
        %{name: "Carbon", number: 6, weight: 12},
        %{name: "Iridium", number: 77, weight: 192}
    ]

    #Calculate neutrons
    r3 = Enum.reduce(elements, [], fn(elem,acc) ->
        IO.inspect(acc, label: "Accumulator")
        IO.inspect(elem, label: "Element")
        neutrons = elem.weight - elem.number
        IO.inspect(neutrons, label: "Neutrons of "<>elem.name)
        IO.inspect([Map.put(elem, :neutrons, neutrons) | acc], label: "Product")
    end)
    IO.inspect(r3, label: "Result")
  end

#Classification
  def example10()do
    elements= [
        %{name: "Hydrogen", group: 1},
        %{name: "Carbon", group: 14},
        %{name: "Iridium", group: 9}
    ]

    IO.inspect(elements, label: "Elements")

    Enum.reduce(elements, [], fn
        %{group: 9} = elem, acc ->
            class = classify(elem, "Transition metal")
            [class | acc]
        %{group: 14} = elem,acc ->
            class = classify(elem, "other non-metal")
            [class | acc]
        _ = elem, acc ->
            class = classify(elem, "Unknown")
            [class | acc]
    end)

  end

  def classify(map, classification) do
    Map.put(map, :classification, classification)
  end


  def add_one(i, counter) when is_integer(i) and is_integer(counter) do
    sum = i + 1
    reduced_counter = counter - 1
    IO.puts(sum)
    add_one(sum,reduced_counter)
  end


  @spec add_one(integer, integer) :: :ok
  def add_one(i, counter) when is_integer(i) and is_integer(counter) and counter <= 1 do
    IO.puts(i+1)
  end

end
