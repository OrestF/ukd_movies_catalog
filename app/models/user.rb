class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :comments, dependent: :destroy

  has_one_attached :avatar do |attachable|
    attachable.variant :tiny, resize_to_limit: [50, 50]
  end

  def full_name
    return email if first_name.blank? && last_name.blank?

    "#{first_name} #{last_name}"
  end
end
