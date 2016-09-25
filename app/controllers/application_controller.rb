class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :is_logged_in

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def is_logged_in
    unless current_user
      flash[:notice] = 'Please login to proceed further'
      redirect_to '/'
    end
  end

  def admin_logged_in
    unless (current_user && current_user.usertype == 'Admin' or current_user.usertype == 'Super Admin')
      flash[:notice] = 'Only admins can view this page.'
      redirect_to '/'
    end
  end



end