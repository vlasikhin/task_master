defmodule TaskMaster.ProjectsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TaskMaster.Projects` context.
  """

  @doc """
  Generate a task.
  """
  def task_fixture(attrs \\ %{}) do
    {:ok, task} =
      attrs
      |> Enum.into(%{
        description: "some description",
        name: "some name"
      })
      |> TaskMaster.Projects.create_task()

    task
  end

  @doc """
  Generate a category.
  """
  def category_fixture(attrs \\ %{}) do
    {:ok, category} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> TaskMaster.Projects.create_category()

    category
  end
end
