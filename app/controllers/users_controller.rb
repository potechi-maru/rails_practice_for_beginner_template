class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to new_user_path, notice: "Welcome, #{@user.name}"
    else
      render :new
    end
  end
  
  # def show
    # @user = User.find_by(email: params[:email])
  # end
  
  private
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

end