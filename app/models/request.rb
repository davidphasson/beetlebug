class Request < ActiveRecord::Base
  
  # E-mail validations
  validates_format_of :contact1_email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i
  validates_format_of :contact2_email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i
  validates_confirmation_of :contact1_email
  validates_confirmation_of :contact2_email
  
  validates_presence_of :school
  
  validates_presence_of :school_mail_address1, :school_mail_city, :school_mail_state, :school_mail_zipcode
  validates_presence_of :contact1_first, :contact1_last, :contact1_position, :contact1_phone, :contact1_email
  validates_presence_of :contact2_first, :contact2_last, :contact2_position, :contact2_phone, :contact2_email
  
  # Need break start/end
  validates_presence_of :winter_break_start, :winter_break_end, :spring_break_start, :spring_break_end
  
  # Need 4 preferred and alternate dates
  validates_presence_of :preferred_date1, :preferred_date2, :preferred_date3, :preferred_date4
  validates_presence_of :alternate_date1, :alternate_date2, :alternate_date3, :alternate_date4
  
  validates_presence_of :school_county, :school_district
  
  
  validates_acceptance_of :book_fair_too_soon, :accept => "no"
  validates_acceptance_of :read_school_info, :accept => "yes"
  validates_acceptance_of :dates_okay, :accept => "yes"
  validates_acceptance_of :students_will_show, :accept => "yes"
  validates_acceptance_of :will_prep, :accept => "yes"
  
  validates_each :preferred_date1, :preferred_date2, :preferred_date3, :preferred_date4,
                  :alternate_date1, :alternate_date2, :alternate_date3, :alternate_date4,
                  :backup_date1, :backup_date2, :backup_date3, :backup_date4 do |record, attr, value|
        # Skip if the value is unset
        next if value.nil?
        # Skip if the breaks aren't defined yet, another validation will find that
        next if record.winter_break_start.nil?
        next if record.winter_break_end.nil?
        next if record.spring_break_start.nil?
        next if record.spring_break_end.nil?
        
        # Obviously can't be during break
        if value > record.winter_break_start && value < record.winter_break_end 
          record.errors.add attr, "is during winter break"
        end
        if value > record.spring_break_start && value < record.spring_break_end 
          record.errors.add attr, "is during spring break"
        end
        # Has to be two weeks after spring/winter break is over
        if value >= record.winter_break_end && value < (record.winter_break_end + 2.weeks)
          record.errors.add attr, "is within two weeks of return from winter break"
        end
        if value >= record.spring_break_end && value < (record.spring_break_end + 2.weeks)
          record.errors.add attr, "is within two weeks of return from spring break"
        end
        # Can't be week just before spring/winter break gets out
        if value <= record.winter_break_start && value > (record.winter_break_start - 1.weeks)
          record.errors.add attr, "is within one week of getting out for spring break"
        end
        if value <= record.spring_break_start && value > (record.winter_break_start - 1.weeks)
          record.errors.add attr, "is within one week of getting out for spring break"
        end
        # Can't be on the weekend
        if value.wday < 1 || value.wday > 5
          record.errors.add attr, "is on the weekend"
        end
        # Can't be in the past or today
        if value <= Date.today
          record.errors.add attr, "must be in the future"
        end

  end
  
  
  
  
  
end
