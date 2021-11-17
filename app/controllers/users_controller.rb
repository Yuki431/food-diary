class UsersController < ApplicationController
  before_action :user_admin, only: [:index]

  def index
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = 'ユーザを登録しました。'
      redirect_to("/")
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end
  
  def destroy
    @user = User.find(current_user.id)
    @user.destroy
    flash[:success] = '退会しました。'
    redirect_to("/")
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def user_admin
    @users = User.all
    if current_user.admin == false
        redirect_to root_path
    end
 end
  
end
