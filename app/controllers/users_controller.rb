class UsersController < ApplicationController
  
  before_action :authenticate_user!
  before_action :is_matching_login_user, only: [:edit, :update]

  def index
    @users = User.all
    @book = Book.new
    @user = current_user
  end

  def show
    @user = User.find(params[:id])
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user == @user
    @book = Book.new
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user)
    else
      flash.now[:alert] = "Error: Failed to update profile."
      render :edit
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path, notice: "User was successfully created."
    else
      flash.now[:alert] = "Error: Failed to create user."
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :profile_image, :introduction)
  end
  
  def book_params
    params.require(:book).permit(:title, :image, :body)
  end

  def is_matching_login_user
    @user = User.find(params[:id])
    unless @user == current_user
      flash[:alert] = "You are not authorized to access this page."
      redirect_to user_path(current_user)
    end
  end
end
