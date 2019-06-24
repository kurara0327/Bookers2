class UsersController < ApplicationController

  def index
    @users = User.all
    @user = current_user
    @book_new = Book.new
  end

  def show
  	@user = User.find(params[:id])
    @book_new = Book.new
  end

  def edit
  	@user = User.find(params[:id])
    if current_user.id != @user.id
      redirect_to user_path(current_user)
    end
  end

  def create
    user = User.new(user_params)
    if user.save
       flash[:notice] = "successfully"
       redirect_to user_path(current_user)
    else
       render "users/index"
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
       flash[:notice] = "successfully"
       redirect_to user_path(@user)
    else
       render 'edit'
    end
  end

  def destroy
  	user = User.find(params[:id])
  	user.destroy
    flash[:notice] = "successfully"
  	redirect_to hooms_path
  end

  private

  def user_params
    params.require(:user).permit(:name,:introduction, :profile_image)
  end

end
