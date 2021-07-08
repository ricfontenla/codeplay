class Api::V1::CoursesController < ActionController::API
  def index
    @courses = Course.all
    render json: @courses.as_json(except: [:id, :created_at, :updated_at, 
                                           :instructor_id], 
                                  include: { instructor: { only: [:name, :email, :bio] } })
  end

  def show
    @course = Course.find_by(code: params[:code])
    if @course
      render json: @course
    else
      head 404
    end
  end

  def create
    @course = Course.new(course_params)
    @course.save!
    render json: @course, status: 201
  rescue ActionController::ParameterMissing
    render json: @course.errors, status: 422
  rescue ActiveRecord::RecordInvalid
    render json: @course.errors, status: 412
  end

  def update
    @course = Course.find_by!(code: params[:code])
    @course.update!(course_params)
    render json: @course
  rescue ActionController::ParameterMissing
    head 422
  rescue ActiveRecord::RecordInvalid
    head 412
  end

  def destroy
    @course = Course.find_by!(code: params[:code])
    @course.destroy
  rescue ActiveRecord::RecordNotFound
    head 404
  end

  private

  def course_params
    params.require(:course).permit(:name, :description, :code, :price, 
                                   :instructor_id, :enrollment_deadline)
  end
end