class ArticlesController < ApplicationController
  before_action :confirm_admin_session, only: [:new, :create, :edit, :update, :destroy, :images_destroy]
  before_action :set_article, only: [:show, :edit, :update, :destroy, :images_destroy]

  PER = 5
  def index
    # @articles = Article.all.reverse
    @articles = Article.order('id DESC').page(params[:page]).per(PER)
  end

  def archive
    year = params[:date][0..3].to_i
    month = params[:date][4..-1].to_i
    date = Date.new(year, month, 1)
    @articles = Article.where(updated_at: date..((date >> 1) -1)).order('id DESC').page(params[:page]).per(PER)
  end

  def search
    if params[:search].present?
      @articles = Article.search(params[:search]).results
    else
      @articles = Article.all.reverse
    end
    # p @articles[0].updated_at
    # raise
  end

  def show
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    respond_to do |format|
      # if @article.save
      #   format.html { redirect_to @article, notice: 'Article was successfully created.' }
      #   format.json { render :show, status: :created, location: @article }
      # else
      #   format.html { render :new }
      #   format.json { render json: @article.errors, status: :unprocessable_entity }
      # end
      begin
        @article.save!
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render :show, status: :created, location: @article }
      rescue
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def images_destroy
    @article.images.destroy_all
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article_images was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_article
      @article = Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:title, :body, images: []) 
    end

    def archive_date_params
      params.permit(:date)
    end

    def confirm_admin_session
      # session[:admin].present? ? true : confirm_permission
      # if session[:admin].present?
      #   true
      # else
      #   redirect_to confirm_authority_path
      # end
      redirect_to confirm_authority_path unless current_user.present?
    end

end
