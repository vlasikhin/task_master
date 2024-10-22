defmodule TaskMaster.Projects.Task do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tasks" do
    field :name, :string
    field :description, :string

    many_to_many :categories, TaskMaster.Projects.Category,
      join_through: "tasks_categories",
      on_delete: :delete_all

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
  end
end
