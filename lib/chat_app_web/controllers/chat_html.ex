defmodule ChatAppWeb.ChatHTML do
  use ChatAppWeb, :html


  embed_templates "chat_html/*"

  attr :user_name, :string
  attr :message, :string
  attr :message_time, :string

  def chat_box(assigns) do
    ~H"""
      <div class="mt-5 border-2 border-orange-500 h-1/5 px-5 rounded-lg shadow-md">
          <div class="w-full pt-2 flex items-center justify-between">
              <h3 class="font-bold text-orange-500">
                <%= @user_name %>
              </h3>
              <p class="text-gray-500 font-medium text-sm">
                <%= @message_time %>
              </p>
          </div>
          <div class="p-2">
              <p class="text-gray-500">
                <%= @message %>
              </p>
          </div>
      </div>
    """
  end
end
