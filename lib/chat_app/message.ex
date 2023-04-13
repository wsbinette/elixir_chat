defmodule ChatApp.Message do
  use Ecto.Schema
  import Ecto.Changeset

  alias ChatApp.{Repo, Message}

  schema "messages" do
    field :content, :string
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:content, :user_id])
    |> validate_required([:content, :user_id])
  end

  def create_message(attrs \\ %{}) do
    %Message{}
    |> Message.changeset(attrs)
    |> Repo.insert()
  end

  def update_message(params) do
    message = Repo.get!(Message, params["id"])
    changeset = changeset(message, params)

    case Repo.update(changeset) do
      {:ok, message} -> {:ok, message}
      {:error, _} -> {:error, "Failed to update message"}
    end
  end

  def delete_message(params) do
    message = Repo.get!(Message, params["id"])

    case Repo.delete(message) do
      {:ok, message} -> {:ok, message}
      {:error, _} -> {:error, "Failed to delete message"}
    end
  end

  def get_message!(id), do: Repo.get!(Message, id)

  def list_messages(), do: Repo.all(Message)
end
