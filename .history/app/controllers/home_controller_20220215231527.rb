class HomeController < ApplicationController
  skip_before_action :authorized, only: [:index]
  def index
    if current_user
      @yourcourses = Course.where(instructoremail: current_user.email)
      # @students = Enroll.where(course_id:)
    end
  end
end
