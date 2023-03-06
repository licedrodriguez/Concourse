defmodule Concourse do
  def doors do
    ["P1", "|P2", "|P3", "|P4", "|P5", "|P6", "|P7", "|P8", "|P9", "|P10" ]
  end

  def awards do
    [0, 0, 0, 0, "X", "X", "X", "$50", "$100", "$200"]
  end

  def init() do
    IO.puts("El concurso del Mago")
    build = build()
    game(build, 0)
  end

  def build do
    player = %{awards: [], tire: 0, accum: 0, empty: 0 }
    %{doors: doors(), awards: awards(), player: player}
  end

  def game(build, r) when r < 6 do
    round = Concourse.round(r)
    IO.puts("Ronda #: #{round}")
    IO.puts("Seleccione una puerta ")
    IO.puts(build.doors)
    IO.puts("\n")
    door = IO.gets("Ingrese el # de la puerta: ") |> String.trim |> String.upcase
    award = build.awards |> Enum.random()
    newPlayer = continue(award, build.player.awards, door)
    newAwards = List.delete(build.awards, award)
    newDoors = updateLists(build.doors, door, award)
    game(%{doors: newDoors, awards: newAwards, player: newPlayer}, r+1)
  end


  def game(_, _) do
    IO.puts("\n El juego ha finalizado")
  end

  def continue(award, awards, door) do
    case award do
      "X" -> IO.puts("La puerta P#{door} esta vacia")
      0 -> IO.puts("Haz obtenido una llanta")
      "$50" -> IO.puts("Obtuviste $50")
      "$100" -> IO.puts("Obtuviste $100")
      "$200" -> IO.puts("Obtuviste $200")
    end

    newAwards = List.insert_at(awards, 0, award)
    tires = Enum.count(newAwards, fn x -> x == 0 end)
    null = Enum.count(newAwards, fn x -> x == "X" end)
    accum = accum(newAwards)
    IO.puts("\n")
    IO.puts("Total dinero acumulado: $#{accum}")
    IO.puts("Total llantas: #{tires}" )
    validate(tires, null)
    %{awards: newAwards, tire: tires, accum: accum, empty: null }
  end

  def validate(tires, null) do
    cond do
      null > 3 -> IO.puts("El juego ha finalizado")
      tires >= 4 -> IO.puts("Ha ganado el carro \n El juego ha finalizado.")
      true -> ""
    end
  end

  def accum(lst) do
    lst |> Enum.map(fn x ->
      case x do
        "$50" -> 50
        "$100" -> 100
        "$200" -> 200
        _ -> 0
      end
    end) |> Enum.sum
  end

  def updateLists(list, door, val) do
    List.replace_at(list, String.to_integer(door) -1, "|#{val}")
  end

  def round(n) do
    n+1
  end
end


Concourse.init()
