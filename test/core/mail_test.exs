defmodule Lyceum.Core.MailTest do
  use Lyceum.ModelCase

  alias Lyceum.Core.Mail

  describe "Mail event flow" do
    test "should send multiple emails" do
      u1 = %Lyceum.Candidate{email: "kobain@nirvana.com", name: "Kurt"} |> Repo.insert!
      u2 = %Lyceum.Candidate{email: "plant@zeppelin.com", name: "Plant"} |> Repo.insert!
      params = %{"to" => "#{u1.id},#{u2.id}",
                 "subject" => "asdfasdf",
                 "body" => "<p>enjoy</p>"
                }

      {:ok, mail} = Mail.send_mail_flow(params)

      assert mail.id
      assert mail.subject == "asdfasdf"
      assert mail.bcc == "admin1@lyceum.com,admin2@lyceum.com"
      assert mail.body == "<p>enjoy</p>"
      assert length(mail.to) == 2
    end
  end

end
