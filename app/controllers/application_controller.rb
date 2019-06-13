class ApplicationController < ActionController::Base
  helper_method :current_user
  before_action :set_archive_link
  # before_action :login_required

  def set_archive_link
    @archive_links = Article.archive
  end

  def current_user
    @current_user ||= User.find_by(id: session[:admin]) if session[:admin]
  end

  # def login_required
  #   redirect_to login_path unless current_user
  # end
end
