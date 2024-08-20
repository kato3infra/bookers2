class BookCommentsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    book = Book.find(params[:book_id])
    comment = current_user.book_comments.new(book_comment_params)
    comment.book_id = book.id
        if comment.save
      flash[:notice] = "Successfully commented."
      redirect_to book_path(book)
    else
      flash[:alert] = "Error: Please enter a comment."
      redirect_to book_path(book)
    end
  end
  
  def destroy
    @book_comment = BookComment.find(params[:id])
    @book = @book_comment.book
    if @book_comment.destroy
      flash[:notice] = "Comment successfully deleted!"
      redirect_to book_path(@book)
    else
      flash[:alert] = "Failed to delete comment."
      redirect_to book_path(@book)
    end
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
  
end
