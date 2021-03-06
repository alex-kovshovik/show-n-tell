defmodule ShowNTellWeb.AuthController do
  use ShowNTellWeb, :controller

  alias ShowNTell.Rest.GithubAuth
  alias ShowNTell.Github.Authenticator

  def create(conn, %{"github_code" => code, "state" => state}) do
    {code, state}
    |> GithubAuth.access_token()
    |> Authenticator.process_token()
    |> render_result(conn)
  end

  defp render_result({:ok, body}, conn) do
    conn
    |> json(body)
  end

  defp render_result({:fail, body}, conn) do
    conn
    |> put_status(401)
    |> json(body)
  end
end
