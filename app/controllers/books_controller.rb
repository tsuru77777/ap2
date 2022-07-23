class BooksController < ApplicationController

 before_action :correct_user, only: [:edit, :update]



 def create
  @newbook=Book.new(book_params)
  @newbook.user_id=current_user.id
  if@newbook.save
   redirect_to book_path(@newbook)
   flash[:notice]="You have created book successfully."
  else
  @user=current_user
  @books=Book.all
  render :index
  end



 end

 def index
  @books=Book.all
  @user=current_user
  @newbook=Book.new

 end

 def show
  @book=Book.find(params[:id])
  @user=@book.user
  @newbook=Book.new
 end

 def edit
  @book=Book.find(params[:id])
 end

 def destroy
  @book=Book.find(params[:id])
  @book.destroy
  redirect_to books_path
 end

 def update
  @book = Book.find(params[:id])
 if@book.update(book_params)
  redirect_to book_path(@book.id)
  flash[:notice]="You have updated book successfully."
 else
  render :edit
 end
 end

 private
 def book_params
  params.require(:book).permit(:title, :body)
 end

 def correct_user
  @book = Book.find(params[:id])
  @user = @book.user
  redirect_to(books_path) unless @user == current_user
 end

end
