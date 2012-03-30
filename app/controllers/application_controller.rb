class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_js_config, :initialize_js_page_vars

  attr_accessor :js_page_vars
  attr_reader :js_config

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

  # set the js config vars
  def set_js_config
    @js_config = {}
  end

  # set the js page vars before running controllers
  def initialize_js_page_vars
    @js_page_vars = {}
  end

end
