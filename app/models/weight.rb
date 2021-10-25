class Weight < ApplicationRecord
  belongs_to :user
  
  validates :daily_weight, presence: true, numericality: true, format: { with: /\A[-]?[0-9]+(\.[0-9]+)?\z/}
  validates :weight_date, presence: true, uniqueness: { scope: :user_id }
end
