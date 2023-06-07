class Api::V1::SuggestionsController < ApplicationController
  before_action :initialize_facade
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  
  def new

  end

  def create
    suggestion = @facade.create_suggestion(suggestion_params)
    if suggestion.persisted?
      render json: SuggestionSerializer.new(suggestion).serializable_hash.to_json, status: 201
    else
      errors_determination(suggestion.errors)
    end
  end

  def update

  end

  def destroy
    suggestion = Suggestion.find_by(user_id: suggestion_params["user_id"], playlist_id: suggestion_params["playlist_id"], request: suggestion_params["request"])
    if suggestion.nil?
      render json: {
        "errors": [
                {
                    "detail": "No Suggestion with user_id=#{suggestion_params["user_id"]} AND playlist_id=#{suggestion_params["playlist_id"]} exists OR request is not found for this playlist and user combination"
                }
            ]
      }, status: 404
    else
      render json: Suggestion.delete(suggestion), status: 204
    end
  end

  private

  def initialize_facade
    @user = User.find(suggestion_params[:user_id])
    @facade = SuggestionFacade.new(@user)
  end

  def suggestion_params
    params.require(:suggestion).permit(:user_id, :playlist_id, :seed_type, :request, :spotify_artist_id, :track_artist)
  end

  def not_found(exception)
    render json: ErrorSerializer.new(exception).user_not_found_serialized_json, status: 404
  end

  def errors_determination(errors)
    if errors.messages.has_key?(:user_id) || errors.messages.has_key?(:playlist_id)
      render json: ErrorSerializer.new(errors).nil_values_serialized_json, status: 400
    else 
      render json: ErrorSerializer.new(errors).user_invalid_attributes_serialized_json, status: 404
    end
  end
end