class BooksController < ApplicationController

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @book_comment = BookComment.new
     @users = User.all
  end

  def index
     @books = Book.all
     @book = Book.new
     @book_comment = BookComment.new
     @user = @book.user
      @users = User.all
  end

  def create
    @user = current_user
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice]= "You have created book successfully."
      redirect_to book_path(@book)
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
     if  @book.user!=current_user
        redirect_to books_path
     end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] ="You have updated book successfully."
      redirect_to book_path(@book)
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title,:body)
  end
end

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
  def post_comment_params
    params.require(:book_comment).permit(:comment)
  end