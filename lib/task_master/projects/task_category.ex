defmodule TaskMaster.Projects.TaskCategory do
  use Ecto.Schema

  @primary_key false
  schema "tasks_categories" do
    field :task_id, :id
    field :category_id, :id

    timestamps()
  end
end
