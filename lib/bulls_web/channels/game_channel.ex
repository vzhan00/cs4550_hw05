defmodule BullsWeb.GameChannel do
  use BullsWeb, :channel

  @impl true
  def join("game:" <> _id, payload, socket) do
    if authorized?(payload) do
      game = Bulls.Game.new()
      socket = assign(socket, :game, game)
      view = Bulls.Game.view(game)
      {:ok, view, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  @impl true
  def handle_in("input", %{"input" => input}, socket) do
    game0 = socket.assigns[:game]

    if Bulls.Game.checkOutcome(game0) do
      view = Bulls.Game.view(game0)
      {:reply, {:ok, view}, socket}
    else
      game1 = Bulls.Game.updateInput(game0, input)
      game2 = Bulls.Game.checkGuess(game1, input)
      socket0 = assign(socket, :game, game2)
      view = Bulls.Game.view(game2)
      {:reply, {:ok, view}, socket0}
    end
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
