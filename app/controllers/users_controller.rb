class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find (params[:id])
  end

  def edit
    @user = User.find (params[:id])
    if @user == current_user #ログインユーザの時editのビューを表示
      render :edit
    else
      redirect_to user_path(current_user) #ログインユーザの詳細画面
    end
  end

end
