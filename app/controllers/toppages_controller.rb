class ToppagesController < ApplicationController
  def index
    
      @day = Date.today.strftime("%Y年%m月%d日")
      @calorie = Food.where(meal_date: @day).where(user_id: current_user.try(:id)).sum(:kcal).round(3)
      @protein = Food.where(meal_date: @day).where(user_id: current_user.try(:id)).sum(:protein).round(3)
      @fat = Food.where(meal_date: @day).where(user_id: current_user.try(:id)).sum(:fat).round(3)
      @carbo = Food.where(meal_date: @day).where(user_id: current_user.try(:id)).sum(:carbo).round(3)
      
      @breakfasts = Food.where("meal_time = '朝食'").where(meal_date: @day).where(user_id: current_user.try(:id))
      @lunches = Food.where("meal_time = '昼食'").where(meal_date: @day).where(user_id: current_user.try(:id))
      @dinners = Food.where("meal_time = '夕食'").where(meal_date: @day).where(user_id: current_user.try(:id))
      @snacks = Food.where("meal_time = '間食'").where(meal_date: @day).where(user_id: current_user.try(:id))
      
      @weight = Weight.where(weight_date: @day).find_by(user_id: current_user.try(:id))
      
      @diary = Diary.where(diary_date: @day).find_by(user_id: current_user.try(:id))
      
  end
end
