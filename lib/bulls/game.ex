defmodule Bulls.Game do
  def new do
      %{
        input: "",
        goal: generateNum(MapSet.new([0, 1, 2, 3, 4, 5, 6, 7, 8, 9]), []),
        result: [],
        guesses: [],
        alert: "",
        gameOver: false,
      }
    end

    def generateNum(mpset, num) do
        if length(num) == 4 do
          num
        else
          curr = Enum.take_random(mpset, 1)
          mpset = MapSet.delete(mpset, curr)
          [num | curr]
          generateNum(mpset, num)
      end
    end

    def updateInput(state, guess) do
      input = String.split(guess, "", trim: true)

      cond do
        length(input) > 4 ->
          %{state |
              input: String.slice(guess, 0..-2)}

        String.match?(guess, ~r/[^\d]/) ->
          %{state |
              input: String.slice(guess, 0..-2)}
        true ->
          %{state |
              input: guess}
      end
    end

    def checkGuess(state, guess) do
      cond do
        (String.length(guess) != 4) ->
          %{state |
              input: "",
              alert: "Number must be 4 characters"}

        (String.match?(guess, ~r/[^\d]/)) ->
          %{state |
            input: "",
            alert: "Digist must all be unique"}

        (String.length(guess) == 4) ->
          newResult = makeResult(state.input, state.goal, 0, 0, 0)
          updatedState = %{ state |
              guesses: state.guesses ++ [guess],
              result: state.result ++ [newResult],
              input: ""}
          cond do
            state.goal == guess ->
              %{updatedState | alert: "You win!", gameOver: true}
            length(state.guesses) == 8 ->
              %{updatedState | alert: "You lose!", gameOver: true}
            true -> updatedState
          end
      end
    end

    def makeResult(input, goal, a, b, index) do
      inputArr = String.split(input, "", trim: true)
      goalArr = (String.split(input, "", trim: true))

      if (index < 4) do
        cond do
          Enum.member?(goalArr, Enum.at(inputArr, index)) ->
            makeResult(input, goal, a, b+1, index+1)
          Enum.at(goalArr, index) == Enum.at(inputArr, index) ->
            makeResult(input, goal, a+1, b, index+1)
          true ->
            makeResult(input, goal, a, b, index+1)
        end
      else
        Integer.to_string(a) <> "A" <> Integer.to_string(b) <> "B"
      end
    end

    def view(st) do
        %{
          currInput: st. input,
          currGuesses: st.guesses,
          currResults: st.result,
          currAlert: st.alert,
        }
    end

    def checkOutcome(st) do
        st.gameOver
    end
end
