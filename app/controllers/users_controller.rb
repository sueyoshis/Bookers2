class UsersController < ApplicationController
  def index
    @book_new = Book.new
    @users = User.all
  end

  def show
    @book_new = Book.new
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

  def update
    user = User.find (params[:id])
    user.update(user_params)
    redirect_to user_path(user) #ユーザの詳細へ遷移
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

end
