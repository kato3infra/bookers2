class BooksController < ApplicationController
  def new
    @book = Book.new
  end

  # 投稿データの保存
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book)
    else
      flash.now[:alert] = "error Failed to create a new book."
      @books = current_user.books
      redirect_back(fallback_location: root_path)
    end
  end

  def index
    @books = Book.all
    @new_book = Book.new
  end

  def show
    @book = Book.find(params[:id])
    @books = current_user.books
    @new_book = Book.new
  end

  def destroy
    book  = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book)
    else
      flash.now[:alert] = "error Failed to update post."
      render :edit
    end
  end

    # 投稿データのストロングパラメータ
  private

  def book_params
    params.require(:book).permit(:book_name, :image, :caption)
  end
end
