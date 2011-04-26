class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  
  def after_sign_in_path_for(resource_or_scope)
    case resource_or_scope
    when :user, User
      store_location = session[:return_to]
      clear_stored_location
      (store_location.nil?) ? "/" : store_location.to_s
    else
      super
    end
  end
  
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to sign_in_path, :alert => "You must sign in to continue." if exception.message == "You must sign in to continue."
    redirect_to root_url, :alert => exception.message
  end
  
  
end
