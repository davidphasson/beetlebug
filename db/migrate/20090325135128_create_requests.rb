class CreateRequests < ActiveRecord::Migration
  def self.up
    create_table :requests do |t|
      # General Page
      t.string :school
      t.integer :assembly_type
      t.integer :starting_grade
      t.integer :ending_grade
      t.integer :num_students
      t.string :author_hosted
      t.string :mike_hosted
      t.string :mike_hosted_year
      # Contacts Page
      t.string :contact1_first
      t.string :contact1_last
      t.string :contact1_position
      t.string :contact1_phone
      t.string :contact1_altphone
      t.string :contact1_fax
      t.string :contact1_email
      t.string :contact2_first
      t.string :contact2_last
      t.string :contact2_position
      t.string :contact2_phone
      t.string :contact2_altphone
      t.string :contact2_email
      t.string :school_principal
      t.string :school_mail_address1
      t.string :school_mail_address2
      t.string :school_mail_city
      t.string :school_mail_state
      t.string :school_mail_country
      t.string :school_mail_zipcode
      t.boolean :school_phys_address_same
      t.string :school_phys_address1
      t.string :school_phys_address2
      t.string :school_phys_city
      t.string :school_phys_state
      t.string :school_phys_zipcode
      t.string :school_phys_country
      t.string :school_county
      t.string :school_district
      # Dates Page
      t.date :winter_break_start
      t.date :winter_break_end
      t.date :spring_break_start
      t.date :spring_break_end
      t.date :last_school_date
      t.date :first_school_date
      t.date :preferred_date1
      t.date :preferred_date2
      t.date :preferred_date3
      t.date :preferred_date4
      t.date :alternate_date1
      t.date :alternate_date2
      t.date :alternate_date3
      t.date :alternate_date4
      t.boolean :backup_dates
      t.date :backup_date1
      t.date :backup_date2
      t.date :backup_date3
      t.date :backup_date4
      t.text :date_comments
      # Times Page
      t.time :assembly_time1
      t.datetime :assembly_time2
      t.datetime :assembly_time3
      t.string :assembly_location
      t.boolean :inclement_lunchroom
      t.text :inclement_plan
      t.boolean :school_prone_weather_delays
      t.text :weather_delay_plan
      t.boolean :lunch_with_mike
      t.datetime :lunch_start
      t.datetime :lunch_end
      t.string :lunch_room
      t.boolean :had_writing_program
      # Schools coordinating with other schools
      t.date :monday_date
      t.string :monday_school
      t.string :monday_contact_first
      t.string :monday_contact_last
      t.string :monday_contact_title
      t.string :monday_contact_email
      t.date :tuesday_date
      t.string :tuesday_school
      t.string :tuesday_contact_first
      t.string :tuesday_contact_last
      t.string :tuesday_contact_title
      t.string :tuesday_contact_email
      t.date :wednesday_date
      t.string :wednesday_school
      t.string :wednesday_contact_first
      t.string :wednesday_contact_last
      t.string :wednesday_contact_title
      t.string :wednesday_contact_email
      t.date :thursday_date
      t.string :thursday_school
      t.string :thursday_contact_first
      t.string :thursday_contact_last
      t.string :thursday_contact_title
      t.string :thursday_contact_email
      t.date :friday_date
      t.string :friday_school
      t.string :friday_contact_first
      t.string :friday_contact_last
      t.string :friday_contact_title
      t.string :friday_contact_email
      # Essay section
      t.text :essay_visit_reason
      t.text :essay_hope_receive
      t.text :essay_writing_approach
      t.text :essay_feel_about_mike
      t.text :essay_prep_plans
      t.text :essay_pta_involvement
      t.text :essay_other
      
      t.timestamps
    end
  end

  def self.down
    drop_table :requests
  end
end
