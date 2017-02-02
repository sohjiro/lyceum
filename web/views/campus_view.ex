defmodule Lyceum.CampusView do
  use Lyceum.Web, :view

  def render("index.json", %{campuses: campuses}) do
    %{campuses: render_many(campuses, Lyceum.CampusView, "campus.json")}
  end

  def render("show.json", %{campus: campus}) do
    %{campus: render_one(campus, Lyceum.CampusView, "campus.json")}
  end

  def render("campus.json", %{campus: campus}) do
    %{
      id: campus.id,
      name: campus.name
    }
  end

end
