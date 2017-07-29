defmodule HabitsWeb.API.V1.AccountController do
  use Habits.Web, :controller

  alias Habits.Repo
  alias HabitsWeb.{Account, Session, API.V1.SessionView}

  @doc """
  Return information about the current user’s account
  """
  def show(conn, _params) do
    conn
    |> render("show.json", account: conn.assigns.current_account)
  end

  @doc """
  Register a new account unless one exists.
  """
  def create(conn, %{"account" => account_params}) do
    with :ok <- can_create_account?(),
      {:ok, account} <- create_account(account_params),
      {:ok, session} <- create_session(account)
    do
      conn
      |> put_status(:created)
      |> render(SessionView, "show.json", session: session)
    else
      {:error, message} ->
        conn
        |> put_status(:forbidden)
        |> render("error.json", message: message)
    end
  end

  defp can_create_account? do
    if Repo.exists?(Account) do
      {:error, "An account already exists. Please log in."}
    else
      :ok
    end
  end

  defp create_account(account_params) do
    %Account{}
    |> Account.changeset(account_params)
    |> Repo.insert
  end

  defp create_session(%Account{id: account_id}) do
    %Session{}
    |> Session.changeset(%{account_id: account_id, location: "Initial registration"})
    |> Repo.insert
  end
end
