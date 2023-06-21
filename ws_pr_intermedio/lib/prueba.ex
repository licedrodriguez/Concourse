defmodule Prueba do
  def equis(n) do
    Enum.each(1..n, fn x ->
      Enum.each(1..n, fn y ->
        if x == y or x + y == n+1 do
          IO.write("X")
        else
          IO.write("_")
        end
      end)
      IO.puts("")
    end)
  end



  def numMayor() do
    myList = [13, 2, 4, 35, 1]
    aux = []

    Enum.each(myList, fn x ->
      if(x > aux)
    end)
    IO.puts(aux)
  end
end
