CATALOG_LOCATION = 'http://catalog.rpi.edu/preview_program.php?catoid=13&poid=%s&returnto=311'

class Program < ActiveRecord::Base
  has_and_belongs_to_many :courses

  # Returns a hash that maps course names to number of courses
  def unique_course_count
    return courses.group(:name).count
  end

  def rpi_url
    return CATALOG_LOCATION % catalog_id
  end

end
