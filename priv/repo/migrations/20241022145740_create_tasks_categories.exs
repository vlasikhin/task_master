defmodule TaskMaster.Repo.Migrations.CreateTasksCategories do
  use Ecto.Migration

  def change do
    create table(:tasks_categories) do
      add :task_id, references(:tasks, on_delete: :delete_all)
      add :category_id, references(:categories, on_delete: :delete_all)

      timestamps()
    end

    create index(:tasks_categories, [:task_id])
    create index(:tasks_categories, [:category_id])
    create unique_index(:tasks_categories, [:task_id, :category_id])
  end
end
