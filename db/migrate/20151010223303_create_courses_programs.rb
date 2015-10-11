class CreateCoursesPrograms < ActiveRecord::Migration
  def change
    create_table :courses_programs do |t|
      t.belongs_to :course, index: true
      t.belongs_to :program, index: true
    end
  end
end
