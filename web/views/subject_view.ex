defmodule Lyceum.SubjectView do
  use Lyceum.Web, :view

  def render("index.json", %{subjects: subjects}) do
    %{subjects: render_many(subjects, Lyceum.SubjectView, "subject.json")}
  end

  def render("show.json", %{subject: subject}) do
    %{subject: render_one(subject, Lyceum.SubjectView, "subject.json")}
  end

  def render("subject.json", %{subject: subject}) do
    %{
      id: subject.id,
      name: subject.name,
      inserted_at: NaiveDateTime.to_date(subject.inserted_at),
      updated_at: NaiveDateTime.to_date(subject.updated_at)
    }
  end

end
