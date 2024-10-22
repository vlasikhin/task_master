defmodule TaskMaster.Projects.Category do
  use Ecto.Schema
  import Ecto.Changeset

  schema "categories" do
    field :name, :string

    many_to_many :tasks, TaskMaster.Projects.Task,
      join_through: "tasks_categories",
      on_delete: :delete_all

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(category, attrs) do
    category
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
