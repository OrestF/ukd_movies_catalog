class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  belongs_to :user

  has_many :comments, as: :commentable, dependent: :destroy

  validates :body, presence: true, length: { minimum: 10, maximum: 500 }

  after_create :send_email

  private

  def send_email
    CommentMailer.with(user: user, comment: self).created.deliver_later
    # CommentMailer.with(user: user, comment: self).created.deliver_now
  end
end
