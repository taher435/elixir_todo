defmodule ElixirTodoWeb.TaskController do
  use ElixirTodoWeb, :controller

  alias ElixirTodo.{TaskManager, TaskManager.Task}

  def index(conn, _params \\ %{}) do
    tasks = TaskManager.list_tasks()

    conn
    |> assign(:tasks, tasks)
    |> render("index.html")
  end

  def new(conn, _) do
    changeset = TaskManager.change_task(%Task{})
    conn
    |> assign(:changeset, changeset)
    |> assign(:submit_to, Routes.task_path(conn, :create))
    |> render("new.html")
  end

  def edit(conn, %{"id" => id}) do
    task = TaskManager.get_task!(id)
    changeset = TaskManager.change_task(task)

    conn
    |> assign(:changeset, changeset)
    |> assign(:submit_to, Routes.task_path(conn, :update, id))
    |> render("new.html")
  end

  def create(conn, %{"task" => task}) do
    case TaskManager.create_task(task) do
      {:ok, _} -> index(conn)
      {:error, errors} ->
        conn
        |> put_flash(:error, errors)
        |> new(%{})
    end
  end

  def update(conn, %{"id" => id, "task" => task}) do
    db_task = TaskManager.get_task!(id)

    case TaskManager.update_task(db_task, task) do
      {:ok, _} -> index(conn)
      {:error, errors} ->
        conn
        |> put_flash(:error, errors)
        |> edit(%{id: task.id})
    end
  end

  defp get_current_user do

  end
end
