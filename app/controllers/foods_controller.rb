class FoodsController < ApplicationController
  before_action :require_user_logged_in, :correct_user
  
  def new
    @food = Food.new
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
