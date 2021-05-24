class LessonsController < ApplicationController
  before_action :set_lesson, only: [:edit, :update, :destroy]
  before_action :get_course
  def new
    @lesson = Lesson.new
  end

  def create
    @lesson = @course.lessons.build(lesson_params)
    if @lesson.save
      redirect_to course_path(@course)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @lesson.update(lesson_params)
      flash[:notice] = t '.success'
      redirect_to course_path(@course)
    else
      render :edit
    end
  end

  def destroy
    @lesson.destroy
    redirect_to @course
    flash[:notice] = 'Aula deletada com sucesso'
  end

  private
  def lesson_params
    params.require(:lesson).permit(:name, :content, :course_id)
  end

  def set_lesson
    @lesson = Lesson.find(params[:id])
  end
end

def get_course
  @course = Course.find(params[:course_id])
end
