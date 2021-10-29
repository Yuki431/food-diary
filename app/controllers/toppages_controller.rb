class ToppagesController < ApplicationController
  def index
    
      @today = Date.today.strftime("%Y年%m月%d日")
      @calorie = current_user.foods.where(meal_date: @today).sum(:kcal).round(3)
      @protein = current_user.foods.where(meal_date: @today).sum(:protein).round(3)
      @fat = current_user.foods.where(meal_date: @today).sum(:fat).round(3)
      @carbo = current_user.foods.where(meal_date: @today).sum(:carbo).round(3)
      
      @breakfasts = current_user.foods.where("meal_time = '朝食'").where(meal_date: @today)
      @lunches = current_user.foods.where("meal_time = '昼食'").where(meal_date: @today)
      @dinners = current_user.foods.where("meal_time = '夕食'").where(meal_date: @today)
      @snacks = current_user.foods.where("meal_time = '間食'").where(meal_date: @today)
      
      @weight = current_user.weights.find_by(weight_date: @today)
      
      @diary = current_user.diaries.find_by(diary_date: @today)
      
  end
end
