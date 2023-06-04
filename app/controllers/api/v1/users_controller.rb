class Api::V1::UsersController < ApplicationController
 rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def show
    render json: UserSerializer.new(User.find(params[:id]))
  end

  def create
    # @user = User.new(user_params)
    # if @user.save
    #   UserMailer.registration_confirmation(@user).deliver
    #   flash[:success] = "Please confirm your email address to continue"
    #   redirect_to user_path(@user)
    # else
    #   flash[:error] = "Ooooppss, something went wrong!"
    #   render 'new'
    # end
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
  
    def not_found(exception)
      render json: ErrorSerializer.new(exception).user_not_found_serialized_json, status: 404
    end

    def user_params
      params.permit(:username, :email, :token, :role, :spotify_id, :email_confirmed, :confirm_token)
    end
end