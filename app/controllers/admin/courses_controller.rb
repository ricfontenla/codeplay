class Admin::CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy, :enroll]
  
  def index
    @courses = Course.all
  end

  def show
  end

  def new
    @course = Course.new
    @instructors = Instructor.all
  end

  def create
    @course = Course.new(course_params)
    if @course.save
      redirect_to [:admin, @course]
    else
      @instructors = Instructor.all
      render :new
    end
  end

  def edit
    @instructors = Instructor.all
  end

  def update
    if @course.update(course_params)
      flash[:notice] = t('.success')
      redirect_to [:admin, @course]
    else
      @instructors = Instructor.all
      render :edit
    end
  end

  def destroy
    @course.destroy
    flash[:notice] = t('.success')
    redirect_to admin_courses_path
  end

  def enroll
    current_user.enrollments.create(course: @course, price: @course.price)
    #Enrollment.create(user: current_user, course: @course, price: @course.price)
    flash[:notice] = 'Curso comprado com sucesso'
    redirect_to my_enrollments_courses_path
  end

  def my_enrollments
    @enrollments = current_user.enrollments
  end

  private

  def set_course
    @course = Course.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:name, :description, :code, :price, 
                                   :enrollment_deadline, :instructor_id)
  end
end