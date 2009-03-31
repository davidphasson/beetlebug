class Request < ActiveRecord::Base
  
  # Page 1
  validates_presence_of :school, :num_students
  validates_presence_of :assembly_type, :starting_grade, :ending_grade, :mike_hosted, :author_hosted, :message => "must be answered"
  validates_numericality_of :num_students, :message => "is not a valid number"
  # Current hacked validation - 1..4 are radio options, otherwise look for a date
  validates_inclusion_of :mike_hosted, :in => (1950..(Date.today.year)).to_a + (1..4).to_a, :message => "is an invalid date"
   # :unless => Proc.new { |r| r.varable <test> })

    
  
  # E-mail validations
  validates_format_of :contact1_email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i
  validates_format_of :contact2_email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i
  validates_confirmation_of :contact1_email
  validates_confirmation_of :contact2_email
  
  

  
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
