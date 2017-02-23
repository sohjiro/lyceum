defmodule Lyceum.Core.Mail do

  import Swoosh.Email

  def send_mail(%{"mail" => params}) do
    new()
    |> to(params["to"])
    |> from({"Dr B Banner", "hulk.smash@example.com"})
    |> subject(params["subject"])
    |> html_body(params["body"])
    |> text_body("some text")
    |> Lyceum.Mailer.deliver
  end

end
