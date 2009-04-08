class Mailman < ActionMailer::Base
  def request_notification(request)
    recipients "David Hasson <dph@funtaff.net>"
    subject "[beetlebug] New Request Submission"
    from "Beetlebug Requests <mailer@beetlebug.net>"
    body :request => request
  end
  
  def request_received(request)
    recipients "#{request.contact1_first} #{request.contact1_last} <#{request.contact1_email}>"
    subject "[beetlebug] Thank you for your assembly request"
    from "Beetlebug Requests <mailer@beetlebug.net>"
    body :request => request
  end
end
