class User::LessonsController < User::UserController
  before_action :set_lesson, only: [:show]
  before_action :get_course
  
  def show
  end

  
  private

  def set_lesson
    @lesson = Lesson.find(params[:id])
  end
end

def get_course
  @course = Course.find(params[:course_id])
end
