class DiariesController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:edit, :update, :destroy]
  
  def new
    @diary = Diary.new
  end
  
  def create
    @diary = current_user.diaries.build(diary_params)
    if @diary.save
      flash[:success] = '運動内容を記録しました。'
      redirect_to root_url
    else
      flash.now[:danger] = '運動内容の記録に失敗しました。'
      render :new
    end
  end

  def edit
    @diary = Diary.find(params[:id])
  end

  def update
    @diary = Diary.find(params[:id])
    
    if @diary.update(diary_params)
      flash[:success] = '運動内容が正常に更新されました'
      redirect_to("/")
    else
      flash.now[:danger] = '運動内容は更新されませんでした'
      render :edit
    end
  end

  def destroy
    @diary.destroy
    flash[:success] = 'メッセージを削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  private

  def diary_params
    params.require(:diary).permit(:content,:diary_date)
  end
  
  def correct_user
    @diary = current_user.diaries.find_by(id: params[:id])
    unless @diary
      redirect_to root_url
    end
  end
end