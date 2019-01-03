class Article < ApplicationRecord
  has_many :comments, dependent: :destroy
  validates :title, presence: true, length: { maximum: 15 }

  def self.archive
    Article.group("CONCAT(YEAR(updated_at), MONTH(updated_at))").count
  end
end
