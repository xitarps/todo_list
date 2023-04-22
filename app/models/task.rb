class Task < ApplicationRecord
  has_many :category_tasks, dependent: :destroy
  has_many :categories, through: :category_tasks

  belongs_to :user

  validates :title, :description, presence: true
end
