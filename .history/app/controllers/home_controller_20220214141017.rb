class HomeController < ApplicationController
  skip_before_action :authorized, only: [:index]
  def index

    @yourcourses = Course.where(instructoremail: current_user.email)
    puts "hello"
  end
end
