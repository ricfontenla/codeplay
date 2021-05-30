class HomeController < ApplicationController
  def index
    @courses = Course.where(enrollment_deadline: Date.current..)
    #@courses = Course.where("enrollment_deadline >= ?", Date.current)
  end
end