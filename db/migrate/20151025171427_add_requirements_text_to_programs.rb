class AddRequirementsTextToPrograms < ActiveRecord::Migration
  def change
    add_column :programs, :requirements_text, :text
  end
end
