class Api::V1::TracksController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
 
   def show
     render json: TrackSerializer.new(Track.find(params[:id]))
   end
 
   def new
   end
 
   def create
     track = Track.new(track_params)
     if track.save
       render json: TrackSerializer.new(track), status: 201
     else
       render json: ErrorSerializer.new(track.errors).track_invalid_attributes_serialized_json, status: 400
     end
   end
 
   def update
     track = Track.find(params[:id])
     if track.update(track_params)
       render json: TrackSerializer.new(track), status: 201
     else
       render json: ErrorSerializer.new(track.errors).track_invalid_attributes_serialized_json, status: 400
     end
   end
 
   def destroy
     track = Track.find(params[:id])
     if track
       Track.destroy(params[:id])
     else
     render json: ErrorSerializer.new(exception).track_not_found_serialized_json, status: 404
     end
   end
 
   private
 
   def not_found(exception)
     render json: ErrorSerializer.new(exception).track_not_found_serialized_json, status: 404
   end
 
   def track_params
     params.require(:track).permit(:name, :spotify_track_id)
   end
 end