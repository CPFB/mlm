class Users::ConfirmationsController < Devise::ConfirmationsController
  
  # GET /resource/confirmation?confirmation_token=abcdef
  def show
    self.resource = resource_class.confirm_by_token(params[:confirmation_token])

    if resource.errors.empty?
      set_flash_message(:notice, :confirmed) if is_navigational_format?
      sign_in(resource_name, resource)
      Instructor.create(:user_id => self.resource.id)
      redirect_to redirect_location(resource_name, resource)
    else
      render :new
    end
  end
end