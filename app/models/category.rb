class Category < ApplicationRecord
  has_many :category_tasks, dependent: :destroy
  has_many :tasks, through: :category_tasks
end
