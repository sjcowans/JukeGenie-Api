class UsersController < ApplicationController
  def show
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.registration_confirmation(@user).deliver
      flash[:success] = "Please confirm your email address to continue"
      redirect_to user_path(@user)
    else
      flash[:error] = "Ooooppss, something went wrong!"
      render 'new'
    end
  end

  def new
  end

  def confirm_email
    user = User.find_by_confirm_token(params[:id])
    if user
      user.email_activate
      flash[:success] = "Welcome to the Sample App! Your email has been confirmed.
      Please sign in to continue."
      redirect_to signin_url
    else
      flash[:error] = "Sorry. User does not exist"
      redirect_to root_url
    end
  end

  private 
  
  def user_params
    params.permit(:username, :email, :token, :role, :spotify_id, :email_confirmed, :confirm_token)
  end
end