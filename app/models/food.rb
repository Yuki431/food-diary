class Food < ApplicationRecord
  belongs_to :user
  
  with_options presence: true do
      validates :name, length: { maximum: 255 }
      validates :kcal
      validates :protein
      validates :fat
      validates :carbo
      validates :meal_date
      validates :meal_time
  end
  
  def start_time
    self.meal_date 
  end
end
