defmodule ChatAppWeb.ChatChannel do
  use ChatAppWeb, :channel

  alias ChatApp.{Repo, Message}

  @impl true
  def join("chat:lobby", _message, socket) do
    {:ok, socket}
    # if authorized?(payload) do
    #   {:ok, socket}
    # else
    #   {:error, %{reason: "unauthorized"}}
    # end
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  @impl true
  def handle_in("new_message", params, socket) do
    case Message.create_message(params) do
      {:ok, message} ->
        broadcast!(socket, "new_message", %{message: message})
        {:noreply, socket}

      {:error, _reason} ->
        {:reply, {:error, 'Failed to create message!'}, socket}
    end
  end

  def handle_in("edit_message", params, socket) do
    case Message.update_message(params) do
      {:ok, message} ->
        broadcast!(socket, "edit_message", %{message: message})
        {:noreply, socket}

      {:error, _reason} ->
        {:reply, {:error, "Failed to edit message"}, socket}
    end
  end

  def handle_in("delete_message", params, socket) do
    case Message.delete_message(params) do
      {:ok, message} ->
        broadcast!(socket, "delete_message", %{message: message})
        {:noreply, socket}

      {:error, _reason} ->
        {:reply, {:error, "Failed to delete message"}, socket}
    end
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (chat:lobby).
  @impl true
  def handle_in("shout", payload, socket) do
    broadcast(socket, "shout", payload)
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
