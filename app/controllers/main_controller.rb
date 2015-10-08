class MainController < ApplicationController
  def index
    @programs = Program.order(:name)
  end
end
