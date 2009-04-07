class Mailman < ActionMailer::Base
  def request_notification(request)
    recipients "David Hasson <dph@funtaff.net>"
    subject "[beetlebug] New Request Submission"
    from "Beetlebug Requests <mailer@beetlebug.net>"
    body :request => request
  end
end
