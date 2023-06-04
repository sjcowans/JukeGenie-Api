class Api::V1::UsersController < ApplicationController
 rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def show
    render json: UserSerializer.new(User.find(params[:id]))
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: UserSerializer.new(user), status: 201
    else 
      render json: ErrorSerializer.new(user.errors).user_invalid_attributes_serialized_json, status: 400
    end
  end

  def new
  end

  def update
    user = User.find(params[:id])
    if user.update(user_params)
      render json: UserSerializer.new(user), status: 201
    else
      render json: ErrorSerializer.new(user.errors).user_invalid_attributes_serialized_json, status: 400
    end
  end

  private 
  
    def not_found(exception)
      render json: ErrorSerializer.new(exception).user_not_found_serialized_json, status: 404
    end

    def user_params
      params.require(:user).permit(:username, :email, :token, :role, :spotify_id)
    end
end