class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book)
    else
      @new_book = @book
      @books = Book.all 
      flash.now[:alert] = @book.errors.full_messages.join(", ")
      render :index
    end
  end

  def index
    @books = Book.all
    @new_book = Book.new
    @user = current_user
  end

  def show
    @book = Book.find(params[:id])
    if @book
      @new_book = Book.new
      @user = @book.user
    else
      flash[:alert] = "Book not found."
      redirect_to books_path
    end
    @book_comment = BookComment.new
  end

  def destroy
    @book = Book.find(params[:id])
    if @book.destroy
      flash[:notice] = "Book was successfully deleted."
    else
      flash[:alert] = "Error: Failed to delete the book."
    end
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
      flash.now[:alert] = "Error: Failed to update the book."
      render :edit
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :image, :body)
  end

  def ensure_correct_user
    @book = Book.find(params[:id])
    @user = @book.user
    unless @user == current_user
      flash[:alert] = "You are not authorized to perform this action."
      redirect_to books_path
    end
  end
end
