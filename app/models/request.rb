class Request < ActiveRecord::Base
  
  # Page 1
  validates_presence_of :school, :num_students
  validates_presence_of :assembly_type, :starting_grade, :ending_grade, :mike_hosted, :author_hosted, :message => "must be answered"
  validates_numericality_of :num_students, :message => "is not a valid number"
  validates_inclusion_of :mike_hosted, :author_hosted, :in => ["yes", "no", "unsure"]
  # Make sure it's a valid year.  No years before 1950
  validates_inclusion_of :mike_hosted_year, :in => (1950..(Date.today.year)).to_a, :allow_blank => true,
    :message => "is an invalid date"
  

    
  
  # E-mail validations
  validates_format_of :contact1_email, :contact2_email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i
  validates_confirmation_of :contact1_email, :contact2_email
  
  # Phone validations, (123) 555-1212, 1-(123)-555-1212, 123-555-1212, 123 555 1212 x123, etc.
  validates_format_of :contact1_phone, :contact2_phone, :contact1_altphone, :contact2_altphone,
      :with => /^1?[\ \-]?\(?[0-9]{3}\)?[\ \-]?[0-9]{3}[\-\ ][0-9]{4}\ ?(x[0-9]+)?$/i, :allow_blank => true;
  # Fax number: same as phone, don't allow extension
  validates_format_of :contact1_fax,
          :with => /^1?[\ \-]?\(?[0-9]{3}\)?[\ \-]?[0-9]{3}[\-\ ][0-9]{4}?$/i, :allow_blank => true;
  
  validates_format_of :monday_contact_email, :tuesday_contact_email, :wednesday_contact_email, :thursday_contact_email, 
                      :friday_contact_email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i, :allow_blank => true;
    

  
  validates_presence_of :school_mail_address1, :school_mail_city, :school_mail_state, :school_mail_zipcode
  validates_presence_of :contact1_first, :contact1_last, :contact1_position, :contact1_phone, :contact1_email
  validates_presence_of :contact2_first, :contact2_last, :contact2_position, :contact2_phone, :contact2_email
  
  # Need break start/end
  validates_presence_of :winter_break_start, :winter_break_end, :spring_break_start, :spring_break_end
  
  # Need 4 preferred and alternate dates
  validates_presence_of :preferred_date1, :preferred_date2, :preferred_date3, :preferred_date4
  validates_presence_of :alternate_date1, :alternate_date2, :alternate_date3, :alternate_date4
  validates_presence_of :last_school_date, :first_school_date
  
  validates_presence_of :school_county, :school_district
  
  validates_presence_of :book_fair_too_soon, :read_school_info, :dates_okay, :students_will_show, :will_prep,
                        :message => "must be answered"
                        
                    
                        
  
  ### Times ###
  validates_presence_of :assembly_time1
  # Must have a second if there is a third
  validates_presence_of :assembly_time2, :if => Proc.new { |r| !r.assembly_time3.nil? },
      :message => "must be specified if Assembly #3 is specified"
  validates_inclusion_of :school_prone_weather_delays, :lunch_with_mike, :inclement_lunchroom, :in => [true, false],
      :message => "must be answered"
  
  
  # Explanation fields must be filled out if a question is true
  validates_presence_of :weather_delay_plan, :if => Proc.new { |r| r.school_prone_weather_delays? == true },
      :message => "must be answered if previous question is true"
  validates_presence_of :inclement_plan, :if => Proc.new { |r| r.inclement_lunchroom? == true },
      :message => "must be answered if previous question is true"
  validates_presence_of :lunch_start, :lunch_end, :lunch_room, :if => Proc.new { |r| r.lunch_with_mike? == true },
      :message => "must be specified for lunch with Mr. Mike"
  # Time specifications:
  validates_each :assembly_time2 do |record, attr, value|
    next if value.nil?
    # Leave this up to other validation
    next if record.assembly_time1.nil?
    if value < ( record.assembly_time1 + 1.hour + 15.minutes )
      record.errors.add attr, "must allow for at least one hour assembly and 15 minute break"
    end
  end
  validates_each :assembly_time3 do |record, attr, value|
    next if value.nil?
    # Leave this up to other validation
    next if record.assembly_time2.nil?
    if value < ( record.assembly_time2 + 1.hour + 15.minutes )
      record.errors.add attr, "must allow for at least one hour assembly and 15 minute break"
    end
  end
  
  # Questions
  validates_acceptance_of :book_fair_too_soon, :accept => "no", 
        :message => "must be answered 'no' to continue"
  validates_acceptance_of :read_school_info, :dates_okay, :students_will_show, :will_prep, :accept => "yes",
        :message => "must be answered 'yes' to continue"
  validates_inclusion_of :had_writing_program, :in => [true, false],
        :message => "must be answered"
  
  # All comment fields but "essay_other" need to be answered
  validates_presence_of :essay_visit_reason, :essay_hope_receive, :essay_writing_approach, :essay_feel_about_mike, :essay_prep_plans, 
  					            :essay_pta_involvement, :message => "must be answered"
  
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
  
  #Lameness
  
 # def assembly_time1=(t)      
  #  if t.nil?
  #    logger.error("assembly_time=: nil passed in")
  #    #return
  #  end
  #  if t.is_a? Hash
  #    logger.error("assembly_time=: it's a hash\n")
  #  else
  #     a = Date.today
  #     #b = DateTime.new(a.year, a.month, a.day, t.hour, t.min)
  #     write_attribute(:assembly_time1, DateTime.now)
  #  end
  #end
  
  #def assembly_time2=(new_time)
  #  if new_time.is_a? Hash
  #    unless new_time["hour"].nil? || new_time["hour"] == "" 
  #      write_attribute "assembly_time2", new_time["hour"] + ":" +
  #        (new_time["minute"]||new_time["min"]||"00") + ":" +
  #        (new_time["second"]||new_time["sec"]||"00")
  #    else 
  #      write_attribute "assembly_time2", nil
  #    end
  #  else
  #    write_attribute "assembly_time2", new_time
  #  end
  # end
  
  
  
end
