class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  belongs_to :user

  has_many :comments, as: :commentable, dependent: :destroy

  validates :body, presence: true, length: { minimum: 10, maximum: 500 }
end
