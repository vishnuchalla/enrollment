class ApplicationController < ActionController::Base
  helper_method :current_user
  before_action :authorized
  helper_method :logged_in?

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    else
      @current_user = nil
    end
  end

  def logged_in?
    !current_user.nil?
  end

  def index
    @current_user ||= User.find(session[:user_id])
    if @current_user.user_type == "instructor"
      @inst = Instructor.where(email: current_user.email).pluck(:name)
      puts "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
      puts @inst
    end
    
  end


  def authorized
    redirect_to root_path unless logged_in?
  end
end
