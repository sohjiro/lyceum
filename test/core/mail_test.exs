defmodule Lyceum.Core.MailTest do
  use Lyceum.ModelCase
  import Swoosh.TestAssertions

  alias Lyceum.Core.Mail

  describe "Mail event flow" do
    test "should send email for listing mails" do

      params = %{"mail" =>
                  %{"to" => "kobain@nirvana.com",
                    "subject" => "asdfasdf",
                    "body" => "<p>enjoy</p>"
                   }
                }
      {:ok, _sended} = Mail.send_mail(params)

      assert_email_sent [subject: "asdfasdf", to: "kobain@nirvana.com"]
    end
  end

end
