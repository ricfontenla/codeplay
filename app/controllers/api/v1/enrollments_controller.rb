class Api::V1::EnrollmentsController < ActionController::API
  def index
    @course = Course.find_by!(code: params[:course_code])
    @enrollments = @course.enrollments
    return render json: { message: 'Nenhuma matrícula registrada para este curso' } unless @enrollments.any?
    render json: @enrollments.as_json(except: [:created_at, :updated_at, :id, :course_id, :user_id, :price],
                                      include: { course: { only: [:name] }, user: { only: [:email] } })
  end
end