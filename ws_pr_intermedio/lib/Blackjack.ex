defmodule Blackjack.Game do
  def suits do
    %{"Corazon" => "C", "Diamante" => "D", "Pica" => "P", "Trebol" => "T"}
  end

  def cards do
    %{"A" => "?", "2" => 2, "3" =>3, "4" => 4,"5" => 5,
           "6" => 6, "7" => 7, "8" => 8, "9" => 9, "10" => 10,
           "J" => 10, "Q" => 10, "K" => 10}
  end

  def init() do
    round = Blackjack.Game.round(0)
    IO.puts("Ronda #: #{round}")
    cardCpu = Blackjack.Game.assign_pc
    cardPlayer = Blackjack.Game.assign_player
    IO.puts("CPU: " <> cardCpu)
    IO.puts("Player: " <> cardPlayer)
    Blackjack.Game.continue(round, cardCpu, cardPlayer, 0, 0)
  end


  def random_card do
    Blackjack.Game.cards |> Enum.random()
  end

  def random_suit do
    Blackjack.Game.suits |> Map.values |> Enum.random()
  end

  def assign_pc do
    pcCard = Blackjack.Game.random_card
    pcSuit = Blackjack.Game.random_suit
    pcKey = Blackjack.Game.getKey(pcCard)
    #pcValue = Blackjack.AssignCard.getValue(pcCard)
    pcKey <> pcSuit
  end

  def getKey(card) do
    elem(card, 0)
  end

  def getValue(card) do
    elem(card, 1)
  end

  def assign_player do
    playerCard = Blackjack.Game.random_card
    playerSuit = Blackjack.Game.random_suit
    playerCv = Blackjack.Game.getKey(playerCard)
    playerCv <> playerSuit
  end

  def round(n) do
    n+1
  end

  def play(r, cardCpu, cardPlayer)  do
    round = Blackjack.Game.round(r)
    IO.puts("Ronda #: #{round}")
    handCpu = cardCpu <> "," <> Blackjack.Game.assign_pc
    handPlayer = cardPlayer <> "," <> Blackjack.Game.assign_player
    IO.puts("CPU: " <>  String.replace(handCpu, ",", " "))
    IO.puts("Player: " <>  String.replace(handPlayer, ",", " "))
    totalCpu = Blackjack.Game.score(handCpu |> String.split(","))
    totalPlayer = Blackjack.Game.score(handPlayer |> String.split(","))
    IO.puts("")
    IO.puts("Total CPU: #{totalCpu}")
    IO.puts("Total Player: #{totalPlayer}")
    continue(round, handCpu, handPlayer, totalCpu, totalPlayer)
  end

  def continue(r, cardCpu, cardPlayer, totalCpu, totalPlayer) when (totalCpu < 21 and totalPlayer < 21) do
    cont = IO.gets("Desea otra carta? S/N: ") |> String.trim |> String.upcase
    case cont do
      "S" -> play(r, cardCpu, cardPlayer)
      "N" -> finish(cardCpu, cardPlayer)
      _ -> IO.puts("Valor no valido")
   end
  end

  def continue(_, cardCpu, cardPlayer, _, _)  do
     finish(cardCpu, cardPlayer)
  end

  def score(hand) do
    aces = hand |> Enum.filter(fn card -> String.first(card) == "A" end)
    non_aces = hand |> Enum.reject(fn card -> String.first(card) == "A" end)
    sum = non_aces |> Enum.map(fn card ->
      case String.first(card) do
        "J" -> 10
        "Q" -> 10
        "K" -> 10
        "10" -> 10
        _ -> String.to_integer(String.first(card))
      end
    end) |> Enum.sum
    aces_sum = aces |> Enum.map(fn _ -> if sum >= 10, do: 1, else: 11 end) |> Enum.sum
    sum + aces_sum
  end

  def validate?(hand) do
    IO.inspect(hand)
    IO.inspect(score(hand))
    IO.inspect(score(hand) > 21)
  end

  def finish(cpuHand, playerHand) do
    totalCpu = score(cpuHand |> String.split(","))
    totalPlayer = score(playerHand |> String.split(","))
    IO.puts(String.duplicate("-",30))
    IO.puts "Total CPU: #{totalCpu}"
    IO.puts "Total Player: #{totalPlayer}"
    # if totalPlayer > totalCpu do
    #   IO.puts("¡Has ganado!")
    # else
    #   IO.puts("Has perdido.")
    # end

    cond do
      totalPlayer < totalCpu   || totalCpu == 21  -> IO.puts("¡Gano CPU!")
      totalCpu < totalPlayer   || totalPlayer == 21 -> IO.puts("¡Has ganado!")
      totalPlayer == totalCpu -> IO.puts("¡Empate!")
      true -> IO.puts("No hay ganador!")

    end
  end
end
