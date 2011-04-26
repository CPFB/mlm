class StudentsController < ApplicationController
  before_filter :redirect_if_not_logged_in
  
  load_and_authorize_resource
  def index
    # debugger
    @students = Student.where(:instructor_id => current_user.instructor.id).all
    # @students = ["foo", "bar"]
  end
  
  def new
  end
  
  def create
    # find school by school_name, otherwise create school. Then save school_id as the (found or created) school's id
    school = School.find_by_school_name(params[:student][:school_id])
    if school
      params[:student][:school_id] = school.id
    else
      new_school = School.create(:school_name => params[:student][:school_id])
      params[:student][:school_id] = new_school.id
    end
    
    @student = Student.new(params[:student])
    
    if @student.save
      redirect_to root_url, :notice => "Student was saved successfully."
    else
      render :new, :alert => "There was a problem saving this student."
    end
  end
  
  def show
  end
  
  def edit
  end
  
  def update
    # find school by school_name, otherwise create school. THen save school_id as the (found or created school's id)
    school = School.find_by_school_name(params[:student][:school_id])
    if school
      params[:student][:school_id] = school.id
    else
      new_school = School.create(:school_name => params[:student][:school_id])
      params[:student][:school_id] = new_school.id
    end

	  if @student.update_attributes(params[:student])
	    redirect_to root_url, :notice => "Student successfully updated."
    else
      render :edit, :notice => "There was a problem saving this student."
    end
  end
  
  def destroy
    @student.destroy
    redirect_to root_url, :notice => "Student was deleted!"
  end
  
    
end
