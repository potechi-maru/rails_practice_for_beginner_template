class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by(email: params[:email])
    if user.present? && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to new_user_path, notice: 'login now'
    else
      render :new
    end
  end
  
  def destroy
  end
  
  

end
