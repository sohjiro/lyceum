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

    test "should reject email send" do
      params = %{"to" => "",
                 "subject" => "asdfasdf",
                 "body" => "<p>enjoy</p>"
                }

      {:error, :bad_request} = Mail.send_mail_flow(params)
    end

    test "should send email to only available candidates" do
      params = %{"to" => "3",
                 "subject" => "asdfasdf",
                 "body" => "<p>enjoy</p>"
                }

      {:ok, mail} = Mail.send_mail_flow(params)

      assert mail.id
      assert mail.subject == "asdfasdf"
      assert mail.bcc == "admin1@lyceum.com,admin2@lyceum.com"
      assert mail.body == "<p>enjoy</p>"
      assert length(mail.to) == 0
    end

    test "should send email to only ids" do
      params = %{"to" => "kobain@nirvana.com",
                 "subject" => "asdfasdf",
                 "body" => "<p>enjoy</p>"
                }

      {:error, :bad_request} = Mail.send_mail_flow(params)
    end
  end

end
