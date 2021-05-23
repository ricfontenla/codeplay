class LessonsController < ApplicationController
  before_action :set_course, only: [:new, :create, :edit, :update]
  def new
    @lesson = Lesson.new
  end

  def create
    @lesson = Lesson.new(lesson_params)
    @lesson.course_id = @course.id
    if @lesson.save
      redirect_to @course
    else
      @course = Course.find(params[:course_id])
      render :new
    end
  end

  def edit
    @lesson = Lesson.find(params[:id])
  end

  def update
    @lesson = Lesson.find(params[:id])
    if @lesson.update(lesson_params)
      redirect_to @course
    else
      render :edit
    end
  end

  private
  def lesson_params
    params.require(:lesson).permit(:name, :content)
  end

  def set_course
    @course = Course.find(params[:course_id])
  end
end
