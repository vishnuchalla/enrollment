class HomeController < ApplicationController
  skip_before_action :authorized, only: [:index]
  def index
    @yourcourses = Course.where(instructor_name: current_user.name)
  end
end
