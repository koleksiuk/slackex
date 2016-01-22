defmodule SlackEx.Api.PingView do
  use SlackEx.Web, :view

  def render("show.json", %{ response: response }) do
    response
  end
end
