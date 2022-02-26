class HomeController < ApplicationController
  skip_before_action :authorized, only: [:index]
  def index
    
    @yourcourses = Course.where(instructor_id: current_user.id)
  end
end
