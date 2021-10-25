class Food < ApplicationRecord
  belongs_to :user
  
  with_options presence: true do
      validates :name, length: { maximum: 255 }
      validates :kcal, numericality: true, format: { with: /\A[-]?[0-9]+(\.[0-9]+)?\z/}
      validates :protein, numericality: true, format: { with: /\A[-]?[0-9]+(\.[0-9]+)?\z/}
      validates :fat, numericality: true, format: { with: /\A[-]?[0-9]+(\.[0-9]+)?\z/}
      validates :carbo, numericality: true, format: { with: /\A[-]?[0-9]+(\.[0-9]+)?\z/}
      validates :meal_date
      validates :meal_time
  end
  
  def start_time
    self.meal_date 
  end
end
