class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]
  
  def index
    @courses = Course.all
  end

  def show
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)
    if @course.save
      redirect_to @course
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @course.update(course_params)
      flash[:notice] = 'Curso atualizado com sucesso'
      redirect_to @course
    else
      render :edit
    end
  end

  def destroy
    @course.destroy
    flash[:notice] = 'Curso apagado com sucesso'
    redirect_to courses_path
  end

  private

  def set_course
    @course = Course.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:name, :description, :code, 
                                   :price, :enrollment_deadline)
  end
end