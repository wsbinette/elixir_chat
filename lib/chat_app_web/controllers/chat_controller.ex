defmodule ChatAppWeb.ChatController do
  use ChatAppWeb, :controller

  def index(conn, _params) do
    titleRaw = Mnemonic.generate()
    |> String.split()
    |> Enum.take(2)
    |> Enum.map_join(" ", &(String.capitalize(&1)))
    
    page_title = "#{titleRaw} Room"
    render(conn, :index, page_title: page_title)
  end
end
