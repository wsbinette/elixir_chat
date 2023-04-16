defmodule ChatAppWeb.ChatController do
  use ChatAppWeb, :controller

  alias ChatApp.{Message}

  def index(conn, _params) do
    titleRaw = Mnemonic.generate()
    |> String.split()
    |> Enum.take(2)
    |> Enum.map_join(" ", &(String.capitalize(&1)))

    message_list = Message.list_messages()

    page_title = "#{titleRaw} Room"
    render(conn, :index, page_title: page_title, message_list: message_list)
  end
end
