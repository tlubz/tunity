class ApplicationController < ActionController::Base
  protect_from_forgery

  def authenticate_user!
    session[:sign_in_last_url] = request.fullpath
    super
  end

  # redirect to the last url from the session on sign in
  def after_sign_in_path_for(resource_or_scope)
    case resource_or_scope
    when :user, User
      store_location = session[:sign_in_last_url]
      session[:sign_in_last_url] = nil
      (store_location.nil?) ? "/" : store_location.to_s
    else
      super
    end
  end

end
