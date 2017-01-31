defmodule Lyceum.TypeView do
  use Lyceum.Web, :view

  def render("index.json", %{types: types}) do
    %{types: render_many(types, Lyceum.TypeView, "type.json")}
  end

  def render("type.json", %{type: type}) do
    %{id: type.id, name: type.name}
  end

end
