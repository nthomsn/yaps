class ProgramsController < ApplicationController
  def show
    @program = Program.find(params[:id])
    @courses = @program.courses
  end
end
