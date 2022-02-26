class HomeController < ApplicationController
  skip_before_action :authorized, only: [:index]
  def index
    @yourcourses = Course.where(instructor_email: current_user.email)
  end
end
