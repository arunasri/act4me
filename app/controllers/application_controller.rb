class ApplicationController < ActionController::Base

  has_mobile_fu

  protect_from_forgery

  rescue_from RuntimeError, :with => :search_error

  private

  def authenticate
    render :text => 'Unauthorized' unless current_user.try(:admin)
  end

  # Do not make this method private. admin_data uses it
  def current_user(user_id = nil)
    if user_id
      session[:user_id] = user_id
    end

    session[:user_id] && @_user ||= User.find(session[:user_id])
  end

  def rescue_action_in_public!(e)
    render :text => e.to_s
  end

  def search_error
    render :text => $!.message, :status => 404
  end
end
