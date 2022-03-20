class BooksController < ApplicationController
  def index
    @book_new = Book.new
    @books = Book.all
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book.id) #本の詳細へ遷移
    else
      @book_new = Book.new
      @books = Book.all
      render :index
    end
  end

  def show
    @book_new = Book.new
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
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book.id) #本の詳細へ遷移
    else
      render :edit
    end
  end

  def destroy
    book = Book.find (params[:id])
    book.destroy
    redirect_to books_path #本の一覧へ遷移
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

end
