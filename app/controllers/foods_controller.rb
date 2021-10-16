class FoodsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:edit, :update, :destroy]
  
  def index
    @foods = Food.all
  end
  
  def new
    @food = Food.new
    @past_food = Food.select(:name,:kcal,:protein,:fat,:carbo).where(user_id: current_user.try(:id)).distinct
  end

  def create
    @food = current_user.foods.build(food_params)
    
    if @food.save
      flash[:success] = '食事を記録しました。'
      redirect_to root_url
    else
      flash.now[:danger] = '食事の記録に失敗しました。'
      render :new
    end
  end
  
  def show
    @day_params = params[:date]
    @day_calorie = Food.where(meal_date: @day_params).where(user_id: current_user.try(:id)).sum(:kcal).round(3)
    @day_protein = Food.where(meal_date: @day_params).where(user_id: current_user.try(:id)).sum(:protein).round(3)
    @day_fat = Food.where(meal_date: @day_params).where(user_id: current_user.try(:id)).sum(:fat).round(3)
    @day_carbo = Food.where(meal_date: @day_params).where(user_id: current_user.try(:id)).sum(:carbo).round(3)
    
    @day_breakfasts = Food.where("meal_time = '朝食'").where(meal_date: @day_params).where(user_id: current_user.try(:id))
    @day_lunches = Food.where("meal_time = '昼食'").where(meal_date: @day_params).where(user_id: current_user.try(:id))
    @day_dinners = Food.where("meal_time = '夕食'").where(meal_date: @day_params).where(user_id: current_user.try(:id))
    @day_snacks = Food.where("meal_time = '間食'").where(meal_date: @day_params).where(user_id: current_user.try(:id))
  end

  def edit
    @food = Food.find(params[:id])
  end

  def update
    @food = Food.find(params[:id])
    
    if @food.update(food_params)
      flash[:success] = '食事が正常に更新されました'
      redirect_to("/")
    else
      flash.now[:danger] = '食事は更新されませんでした'
      render :edit
    end
  end

  def destroy
    @food.destroy
    flash[:success] = '食事を削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def food_params
    params.require(:food).permit(:name,:kcal,:protein,:fat,:carbo,:meal_date,:meal_time)
  end

  def correct_user
    @food = current_user.foods.find_by(id: params[:id])
    unless @food
      redirect_to root_url
    end
  end
end
