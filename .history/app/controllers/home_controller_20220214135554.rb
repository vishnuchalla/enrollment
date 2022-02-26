class HomeController < ApplicationController
  skip_before_action :authorized, only: [:index]
  def index
    @yourcourses = Course.where(Course.first.user: current_user.id)
  end
end
