defmodule Lyceum.Core.MailTest do
  use Lyceum.ModelCase
  # import Swoosh.TestAssertions

  alias Lyceum.Core.Mail

  describe "Mail event flow" do
    test "should send multiple emails" do
      u1 = %Lyceum.Candidate{email: "kobain@nirvana.com", name: "Kurt"} |> Repo.insert!
      u2 = %Lyceum.Candidate{email: "plant@zeppelin.com", name: "Plant"} |> Repo.insert!
      params = %{"to" => "#{u1.id},#{u2.id}",
                 "subject" => "asdfasdf",
                 "body" => "<p>enjoy</p>"
                }

      mails = Mail.send_mail(params)

      assert length(mails) == 2
    end
  end

end
