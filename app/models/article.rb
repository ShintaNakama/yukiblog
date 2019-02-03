class Article < ApplicationRecord
  include ArticleSearchable
  has_many :comments, dependent: :destroy
  has_many_attached :images, dependent: :destroy
  validates :title, presence: true


  def self.archive
    Article.group("CONCAT(YEAR(updated_at), MONTH(updated_at))").count
  end

  # def self.search(search)
  #   return Article.all unless search
  #   Article.where(["CONCAT(title, body) LIKE ?", "%#{search}%"])
  # end
end
