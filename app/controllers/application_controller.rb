class ApplicationController < ActionController::Base
  before_action :set_archive_link

  def set_archive_link
    @archive_links = Article.archive
  end
end
