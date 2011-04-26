class LessonsController < ApplicationController
  before_filter :redirect_if_not_logged_in
  load_and_authorize_resource
  
  def index
    @lessons = Lesson.where(:instructor_id => current_user.instructor.id)
  end
  
  def new
    @students = Student.where(:instructor_id => current_user.id)
  end
  
  def create
    # @lesson.set_balance
    # completely untested code here
    # need to write tons of functional tests to make sure that this works properly
        
    if @lesson.save
      redirect_to root_path, :notice => "Lesson saved successfully."
    else
      render :new, :notice => "There were problems saving this lesson."
    end
  end
  
  def show
  end
  
  
  def edit
    @students = Student.where(:instructor_id => current_user.id)
  end
  
  def update
    if @lesson.update_attributes(params[:lesson])
      redirect_to root_path, :notice => "Lesson was updated successfully."
    else
      render :edit, :notice => "There were problems saving this lesson."
    end
  end
  
  def destroy
    @lesson.destroy
    redirect_to root_path, :notice => "Lesson was deleted."
  end
  
end
