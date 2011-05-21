class ApplicationController < ActionController::Base

  protect_from_forgery

  has_mobile_fu

  rescue_from RuntimeError, :with => :search_error

  USERNAME = 'admin'

  #first registered app name
  PASSWORD = '7b143a54b2b5c19d0626c93f579c655579fa02e2'

  before_filter :authenticate, :only => :login

  def login
    redirect_to fresh_movie_path(Movie.last)
  end

  def logout
    session[:admin] = false
    redirect_to fresh_movie_path(Movie.last)
  end

  def rescue_action_in_public!(e)
    render :text => e.to_s
  end

  private

  def search_error
    render :text => $!.message, :status => 404
  end

  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == USERNAME &&  Digest::SHA1.hexdigest(password) == PASSWORD && admin!
    end
  end

  helper do
    def admin?
      session[:admin]
    end
  end

  def admin!
    session[:admin] = true
  end
end
