class UsersController < ApplicationController
  before_action :authenticate_user!

  def new
    @book = Book.new
  end

  def create
    @user = current_user
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] ="You have created book successfully."
      redirect_to book_path(@book.id)
    end
  end


  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book_new = Book.new
    @book = Book.new

  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render :edit
    else
      redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] ="You have updated user successfully."
      redirect_to user_path(@user)
    else
      @books = Book.all
      @book_new = Book.new
      render :edit
    end
  end

  def index
    @users = User.all
    @books = Book.all
    @book_new = Book.new
    @book = Book.new
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

end
