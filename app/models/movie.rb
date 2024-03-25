class Movie < ApplicationRecord
  GENRES = %w[action comedy drama horror romance thriller sci-fi fantasy animation documentary musical western].freeze

  has_many :comments, as: :commentable, dependent: :destroy

  validates :title, :year_of_creation, presence: true
  validates :title, uniqueness: { scope: %i[duration] }
  validates :description, length: { minimum: 10 }
  validate :genres_validation

  private

  def genres_validation
    unless genres.is_a?(Array) && genres.any?(&:present?)
      errors.add(:genres, 'at least one genre must be selected')
    end
  end
end
