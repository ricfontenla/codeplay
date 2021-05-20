class InstructorsController < ApplicationController
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
      flash[:notice] = 'Professor cadastrado com sucesso'
      redirect_to @instructor
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @instructor.update(instructor_params)
      flash[:notice] = 'Professor editado com sucesso'
      redirect_to @instructor
    else
      render :edit
    end
  end

  def destroy
    @instructor.destroy
    flash[:notice] = 'Professor apagado com sucesso'
    redirect_to instructors_path
  end

  private

  def set_instructor
    @instructor = Instructor.find(params[:id])
  end

  def instructor_params
    params.require(:instructor).permit(:name, :email, :bio, :profile_picture)
  end
end