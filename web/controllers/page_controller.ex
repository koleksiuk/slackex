defmodule SlackEx.PageController do
  use SlackEx.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
