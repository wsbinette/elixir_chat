defmodule ChatAppWeb.ChatController do
  use ChatAppWeb, :controller

  def index(conn, _params) do
    render(conn, :index)
  end
end
