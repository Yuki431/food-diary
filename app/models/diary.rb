class Diary < ApplicationRecord
  belongs_to :user
  
  validates :content, presence: true, length: { maximum: 255 }
  validates :diary_date, presence: true,uniqueness: { scope: :user_id }
end
