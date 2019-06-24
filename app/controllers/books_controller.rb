class BooksController < ApplicationController

  def show
    @book_new = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def index
    @books = Book.all
    @book_new = Book.new
    @user = current_user
  end

  def new
  	@book = Book.new
    @book_new = Book.new
  end

  def edit
   @user = current_user
   if current_user.id != Book.find(params[:id]).user.id
      redirect_to books_path
    else
      @book = Book.find(params[:id])
    end
  end

  def create
    @book_new = Book.new(book_params)
    @book_new.user_id = current_user.id
    if @book_new.save
       flash[:notice] = "successfully"
       redirect_to book_path(@book_new.id)
    else
       @books = Book.all
       @user = current_user
       render ("books/index")
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
       flash[:notice] = "successfully"
       redirect_to book_path(@book.id)
    else
       render ("books/edit")
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    flash[:notice] = "successfully"
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

end