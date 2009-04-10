class FixYearField < ActiveRecord::Migration
  def self.up
     remove_column :requests, :mike_hosted_year
     add_column :requests, :mike_hosted_year, :integer
  end

  def self.down
    remove_column :requests, :mike_hosted_year
    add_column :requests, :mike_hosted_year, :string
  end
end
