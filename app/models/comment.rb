class Comment < ApplicationRecord
  belongs_to :article
  validates :commenter, presence: true, length: { maximum: 15 }
end
