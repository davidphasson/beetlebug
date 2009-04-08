# Convert integer fields to string fields (doh!)
class Convertgradefields < ActiveRecord::Migration
  def self.up
      remove_column :requests, :starting_grade
      add_column :requests, :starting_grade, :string
      remove_column :requests, :ending_grade
      add_column :requests, :ending_grade, :string
  end

  def self.down
    remove_column :requests, :starting_grade
    add_column :requests, :starting_grade, :integer
    remove_column :requests, :ending_grade
    add_column :requests, :ending_grade, :integer
  end
end
