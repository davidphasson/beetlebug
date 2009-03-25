class Request < ActiveRecord::Base
  
  # E-mail validations
  validates_format_of :contact1_email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i
  validates_format_of :contact2_email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i
  validates_confirmation_of :contact1_email
  validates_confirmation_of :contact2_email
  
  
end
