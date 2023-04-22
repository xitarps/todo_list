class Task < ApplicationRecord
  has_many :category_tasks, dependent: :destroy
  has_many :categories, through: :category_tasks

  belongs_to :user

  validates :title, :description, presence: true

  scope :search, ->(term) {
    joins(:categories).where(
      'title ILIKE :query OR description ILIKE :query', query: "%#{term}%"
    ).or(where('categories.name ILIKE :query', query: "%#{term}%"))
  }
end
