class HomeController < ApplicationController
  skip_before_action :authorized, only: [:index]

  def index
    @courses = Course.all
    @students = Student.all
    @instructors = Instructor.all
    if current_user
      @yourcourses = Course.where(instructoremail: current_user.email)
      # @students = Enroll.where(course_id:)
    end
    @courses = Course.all
    @students = Student.all
    @instructors = Instructor.all
  end

end
