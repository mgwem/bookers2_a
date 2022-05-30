class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  has_many :liked_users, through: :favorites, source: :user

  validates :title, presence: true
  validates :body, presence: true, length: {maximum:200}

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def self.looks(search, word)
    if search == "perfect_match"
      Book.where("title LIKE?","#{word}")
    elsif search == "forward_match"
      Book.where("title LIKE?","#{word}%")
    elsif search == "backward_match"
      Book.where("title LIKE?","%#{word}")
    elsif search == "partial_match"
      Book.where("title LIKE?","%#{word}%")
    end
  end
end
