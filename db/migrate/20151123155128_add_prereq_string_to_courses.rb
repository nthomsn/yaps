class AddPrereqStringToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :prereq_string, :string
  end
end
