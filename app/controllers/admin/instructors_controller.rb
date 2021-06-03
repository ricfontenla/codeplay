class Admin::InstructorsController < Admin::AdminController
  before_action :set_instructor, only: [:show, :edit, :update, :destroy]

  def index
    @instructors = Instructor.all
  end

  def show
  end

  def new
    @instructor = Instructor.new
  end
  
  def create
    @instructor = Instructor.new(instructor_params)
    if @instructor.save
      redirect_to [:admin, @instructor]
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @instructor.update(instructor_params)
      flash[:notice] = t('.success')
      redirect_to [:admin, @instructor]
    else
      render :edit
    end
  end

  def destroy
    if @instructor.courses.blank?
      @instructor.destroy
      flash[:notice] = t('.success')
      redirect_to admin_instructors_path
    else
      flash[:notice] = t('.fail')
      render :show 
    end
  end

  private

  def set_instructor
    @instructor = Instructor.find(params[:id])
  end

  def instructor_params
    params.require(:instructor).permit(:name, :email, :bio, :profile_picture)
  end
end