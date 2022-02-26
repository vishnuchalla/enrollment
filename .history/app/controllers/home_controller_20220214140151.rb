class HomeController < ApplicationController
  skip_before_action :authorized, only: [:index]
  def index
    @yourcourses = Course.Instructor.where(Instructor.id: current_user.id)
  end
end
