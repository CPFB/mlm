class SchoolsController < ApplicationController
  before_filter :redirect_if_not_logged_in
  load_and_authorize_resource
  
  def index
  end
  
  def new
  end

  def create
    if @school.save
      redirect_to root_path, :notice => "School saved successfully."
    else
      render :new, :notice => "There was a problem saving this school."
    end
  end
  
  def show
  end

  def edit
  end

  def update
    if @school.update_attributes(params[:school])
      redirect_to root_path, :notice => "School was updated successfully."
    else
      render :edit, :notice => "There was a problem saving your changes."
    end
  end

end
