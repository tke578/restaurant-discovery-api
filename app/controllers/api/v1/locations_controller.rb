class Api::V1::LocationsController < ApplicationController
	before_action :is_authorized

	def search
		begin
			@locations = Locations.new(location_params, @user.favorite_locations)
			if @locations.valid?
				response = @locations.near_by
				render json: {results: response}
			else
				render json: {error: @locations.errors.full_messages.join(",") }, status: :bad_request
			end
		rescue BadRequest => e
			render json: {error: e}, status: :bad_request
		end
	end

	def add_favorite
		@new_location = FavoriteLocation.new(location_params)
		@new_location.user = @user
		if @new_location.valid?
			@new_location.save
			render json: { msg: 'Favorite location has been added.' }
		else
			render json: {error: @new_location.errors.full_messages.join(",") }, status: :bad_request
		end
	end

	def remove_favorite
		@location = FavoriteLocation.find_by(user_id: @user, location_id: params[:location_id])
		if @location.blank?
			render json: {error: 'Unable to find that location.' }, status: :bad_request
		else
			@location.destroy
			render json: { msg: 'This location has been removed from your favorites.'}
		end
	end


	private
	def location_params
		params.permit(:type, :keyword, :radius, :address, :latitude, :longitude, :location_id)
	end

end