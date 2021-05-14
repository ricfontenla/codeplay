class CoursesController < ApplicationController
  def index
    @courses = Course.all
  end

  def show
    @course = Course.find(params[:id])
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new(recipe_params)
    if @course.save
      redirect_to @course
    else
      render :new
    end
  end

  private

  def recipe_params
    params.require(:course).permit(:name, :description, :code, 
                                   :price, :enrollment_deadline)
  end
end