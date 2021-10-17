class Weight < ApplicationRecord
  belongs_to :user
  
  validates :daily_weight, presence: true
  validates :weight_date, presence: true,uniqueness: { scope: :user_id }
end
