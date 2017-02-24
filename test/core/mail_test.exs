defmodule Lyceum.Core.MailTest do
  use Lyceum.ModelCase
  # import Swoosh.TestAssertions

  alias Lyceum.Core.Mail

  describe "Mail event flow" do
    test "should prepare email for to" do
      u1 = %Lyceum.Candidate{email: "kobain@nirvana.com", name: "Kurt"} |> Repo.insert!

      params = %{"to" => "#{u1.id}",
                 "subject" => "asdfasdf",
                 "body" => "<p>enjoy</p>"
                }

      mail = Mail.prepare_mail(params)

      assert mail.to == [{"Kurt", "kobain@nirvana.com"}]
      assert mail.subject == "asdfasdf"
      assert mail.from == {"test", "test@lyceum.com"}
      # assert_email_sent [subject: "asdfasdf", to: [{"Kurt", "kobain@nirvana.com"}]]
    end
  end

end
