class BooksController < ApplicationController
  def index
    @book = Book.new
    @books = Book.all
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @book.save
    redirect_to book_path(@book.id) #本の詳細へ遷移
  end

  def show
    @book = Book.find (params[:id])
    @user = @book.user
  end

  def edit
    @book = Book.find (params[:id])
    if @book.user == current_user #ログインユーザの時editのビューを表示
      render :edit
    else
      redirect_to books_path #それ以外の時は本の一覧へ遷移
    end
  end

  def update
    @book = Book.find (params[:id])
    @book.update(book_params)
    redirect_to book_path(@book.id) #本の詳細へ遷移
  end

  def destroy
    @book = Book.find (params[:id])
    @book.destroy
    redirect_to books_path #本の一覧へ遷移
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

end
