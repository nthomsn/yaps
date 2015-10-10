class Course
  def initialize(course_str)
    paren_index = course_str.index('(')
    @name = course_str[0..paren_index-1].strip
    credits_str = course_str[paren_index+1..paren_index+2]
    @credits = credits_str.to_i
  end

  def display
    puts @name + '(' + @credits.to_s + ')'
  end
end
