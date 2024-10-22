defmodule TaskMaster.ProjectsTest do
  use TaskMaster.DataCase

  alias TaskMaster.Projects
  alias TaskMaster.Projects.{Task, Category}

  @valid_task_attrs %{name: "Test Task", description: "Test Description"}
  @valid_category_attrs %{name: "Test Category"}
  @invalid_task_attrs %{name: nil, description: nil}
  @invalid_category_attrs %{name: nil}

  describe "tasks" do
    import TaskMaster.ProjectsFixtures

    test "list_tasks/0 returns all tasks" do
      task = task_fixture()
      assert Projects.list_tasks() == [task]
    end

    test "get_task!/1 returns the task with given id" do
      task = task_fixture()
      assert Projects.get_task!(task.id) == task
    end

    test "create_task/1 with valid data creates a task" do
      assert {:ok, %Task{} = task} = Projects.create_task(@valid_task_attrs)
      assert task.name == "Test Task"
      assert task.description == "Test Description"
    end

    test "create_task/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Projects.create_task(@invalid_task_attrs)
    end

    test "update_task/2 with valid data updates the task" do
      task = task_fixture()
      update_attrs = %{name: "Updated Task", description: "Updated Description"}

      assert {:ok, %Task{} = task} = Projects.update_task(task, update_attrs)
      assert task.name == "Updated Task"
      assert task.description == "Updated Description"
    end

    test "update_task/2 with invalid data returns error changeset" do
      task = task_fixture()
      assert {:error, %Ecto.Changeset{}} = Projects.update_task(task, @invalid_task_attrs)
      assert task == Projects.get_task!(task.id)
    end

    test "delete_task/1 deletes the task" do
      task = task_fixture()
      assert {:ok, %Task{}} = Projects.delete_task(task)
      assert_raise Ecto.NoResultsError, fn -> Projects.get_task!(task.id) end
    end

    test "change_task/1 returns a task changeset" do
      task = task_fixture()
      assert %Ecto.Changeset{} = Projects.change_task(task)
    end
  end

  describe "categories" do
    import TaskMaster.ProjectsFixtures

    test "list_categories/0 returns all categories" do
      category = category_fixture()
      assert Projects.list_categories() == [category]
    end

    test "get_category!/1 returns the category with given id" do
      category = category_fixture()
      assert Projects.get_category!(category.id) == category
    end

    test "create_category/1 with valid data creates a category" do
      assert {:ok, %Category{} = category} = Projects.create_category(@valid_category_attrs)
      assert category.name == "Test Category"
    end

    test "create_category/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Projects.create_category(@invalid_category_attrs)
    end

    test "update_category/2 with valid data updates the category" do
      category = category_fixture()
      update_attrs = %{name: "Updated Category"}

      assert {:ok, %Category{} = category} = Projects.update_category(category, update_attrs)
      assert category.name == "Updated Category"
    end

    test "update_category/2 with invalid data returns error changeset" do
      category = category_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Projects.update_category(category, @invalid_category_attrs)

      assert category == Projects.get_category!(category.id)
    end

    test "delete_category/1 deletes the category" do
      category = category_fixture()
      assert {:ok, %Category{}} = Projects.delete_category(category)
      assert_raise Ecto.NoResultsError, fn -> Projects.get_category!(category.id) end
    end

    test "change_category/1 returns a category changeset" do
      category = category_fixture()
      assert %Ecto.Changeset{} = Projects.change_category(category)
    end
  end

  describe "Cascade deletes between tasks and categories" do
    test "deleting a task cascades to tasks_categories" do
      {:ok, task} = Projects.create_task(@valid_task_attrs)
      {:ok, category} = Projects.create_category(@valid_category_attrs)

      Projects.add_category_to_task(task, category)

      assert {:ok, %Task{}} = Projects.delete_task(task)

      refute Repo.get_by(TaskMaster.Projects.TaskCategory, task_id: task.id)
    end

    test "deleting a category cascades to tasks_categories" do
      {:ok, task} = Projects.create_task(@valid_task_attrs)
      {:ok, category} = Projects.create_category(@valid_category_attrs)

      Projects.add_category_to_task(task, category)

      assert {:ok, %Category{}} = Projects.delete_category(category)

      refute Repo.get_by(TaskMaster.Projects.TaskCategory, category_id: category.id)
    end
  end
end
