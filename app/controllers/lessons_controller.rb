class LessonsController < ApplicationController
  before_action :set_course
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
      flash[:notice] = t '.success'
      redirect_to @course
    else
      render :edit
    end
  end

  def destroy
    lesson = Lesson.find(params[:id])
    lesson.destroy
    redirect_to @course
    flash[:notice] = 'Aula deletada com sucesso'
  end

  private
  def lesson_params
    params.require(:lesson).permit(:name, :content)
  end

  def set_course
    @course = Course.find(params[:course_id])
  end
end
