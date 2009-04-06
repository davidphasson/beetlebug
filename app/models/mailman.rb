class Mailman < ActionMailer::Base
  def request_notification(request)
    recipients "dph@funtaff.net"
    subject "[beetlebug] New Request Submission"
    from "mailer@beetlebug.net"
    body :request => request
  end
end
