class AddIdstringToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :idstring, :string
  end
end
