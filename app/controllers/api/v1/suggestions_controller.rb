class Api::V1::SuggestionsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  def new

  end

  def create
    suggestion = Suggestion.new(suggestion_params)
    if suggestion.save
      render json: SuggestionSerializer.new(suggestion), status: 201
    else
      errors_determination(suggestion.errors)
    end
    # if artist conversion table empty
    #   table info = SearchFacade.new(convert stuff)
    #   Conversion.create! with table info
    # end
    # make it with ids
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
    def suggestion_params
      params.require(:suggestion).permit(:user_id, :playlist_id, :media_type, :request, :spotify_artist_id, :track_artist)
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