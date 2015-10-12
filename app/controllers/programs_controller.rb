class ProgramsController < ApplicationController
  def show
    @program = Program.find(params[:id])
    @course_count = @program.unique_course_count
    @course_names = @course_count.keys
  end
end
