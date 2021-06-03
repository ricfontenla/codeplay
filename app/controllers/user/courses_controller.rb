class User::CoursesController < User::UserController
  before_action :set_course, only: [:show, :enroll]
  
  def show
  end

  def enroll
    current_user.enrollments.create(course: @course, price: @course.price)
    #Enrollment.create(user: current_user, course: @course, price: @course.price)
    flash[:notice] = 'Curso comprado com sucesso'
    redirect_to my_enrollments_user_courses_path
  end

  def my_enrollments
    @enrollments = current_user.enrollments
  end


  private

  def set_course
    @course = Course.find(params[:id])
  end
end