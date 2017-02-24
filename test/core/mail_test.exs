defmodule Lyceum.Core.MailTest do
  use Lyceum.ModelCase
  # import Swoosh.TestAssertions

  alias Lyceum.Core.Mail

  describe "Mail event flow" do
    test "should prepare email for send" do
      u1 = %Lyceum.Candidate{email: "kobain@nirvana.com", name: "Kurt"} |> Repo.insert!

      params = %{"to" => "#{u1.id}",
                 "subject" => "asdfasdf",
                 "body" => "<p>enjoy</p>"
                }

      mail = Mail.prepare_mail(params)

      assert mail.to == [{"Kurt", "kobain@nirvana.com"}]
      assert mail.subject == "asdfasdf"
      assert mail.from == {"test", "test@lyceum.com"}
      assert mail.bcc == [{"admin1", "admin1@lyceum.com"}, {"admin2", "admin2@lyceum.com"}]
    end

    test "should send multiple emails" do
      u1 = %Lyceum.Candidate{email: "kobain@nirvana.com", name: "Kurt"} |> Repo.insert!
      u2 = %Lyceum.Candidate{email: "plant@zeppelin.com", name: "Plant"} |> Repo.insert!
      params = %{"to" => "#{u1.id},#{u2.id}",
                 "subject" => "asdfasdf",
                 "body" => "<p>enjoy</p>"
                }

      {:ok, mail} = Mail.send_mail(params)

      assert mail.id
    end
  end

end
