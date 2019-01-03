class ArticlesController < ApplicationController
  def index
    @articles = Article.all.reverse
  end

  def archive
    year = params[:date][0..3].to_i
    month = params[:date][4..-1].to_i
    date = Date.new(year, month, 1)
    @articles = Article.where(updated_at: date..((date >> 1) -1)).reverse
  end

  def search
  end

  def sho
    @article = Article.find(params[:id])
  end

  def ne
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to articles_path
  end

  private
    def article_params
      params.require(:article).permit(:title, :body)
    end

    def archive_date_params
      params.permit(:date)
    end
end
