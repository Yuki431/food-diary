class WeightsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:edit, :update, :destroy]
  
  
  def new
    @weight = Weight.new
  end

  def create
    @weight = current_user.weights.build(weight_params)
    if @weight.save
      flash[:success] = '体重を記録しました。'
      redirect_to root_url
    else
      flash.now[:danger] = '体重の記録に失敗しました。'
      render :new
    end
  end

  def edit
    @weight = Weight.find(params[:id])
  end

  def update
    @weight = Weight.find(params[:id])
    
    if @weight.update(weight_params)
      flash[:success] = '体重が正常に更新されました'
      redirect_to("/")
    else
      flash.now[:danger] = '体重は更新されませんでした'
      render :edit
    end
  end

  def destroy
    @weight.destroy
    flash[:success] = '体重を削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  private

  def weight_params
    params.require(:weight).permit(:daily_weight,:weight_date)
  end

  def correct_user
    @weight = current_user.weights.find_by(id: params[:id])
    unless @weight
      redirect_to root_url
    end
  end
end
