defmodule Lyceum.Core.Mail.Sender do
  import Swoosh.Email

  def sender(mail) do
    new()
    |> to({"user", "user@lkjasdf"})
    |> from({"Dr B Banner", "hulk.smash@example.com"})
    |> subject("Hello, Avengers!")
    |> html_body("<h1>Hello avenger</h1>")
    |> text_body("Hello avenger\n")
    |> Lyceum.Mailer.deliver
  end

end
