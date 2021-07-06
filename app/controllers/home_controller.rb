class HomeController < ApplicationController
  
  layout :verify_layout
  
  def index
    @courses = Course.available         #scope
    #@courses = Course.where("enrollment_deadline >= ?", Date.current)
  end

  private

  def verify_layout
    if admin_signed_in?
      'admin'
    elsif user_signed_in?
      'user'
    else
      'application'
    end
  end
end

