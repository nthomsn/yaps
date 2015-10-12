class Program < ActiveRecord::Base
  has_and_belongs_to_many :courses

  # Returns a hash that maps course names to number of courses
  def unique_course_count
    return courses.group(:name).count
  end

end
