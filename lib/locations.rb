class Locations
	include ActiveModel::Validations

	validates_presence_of :radius
	validate :check_location

	attr_accessor :keyword, :radius, :latitude, :longitude, :type

	def initialize(params, fav_locations)
		@type						= params["type"]	  || 'restaurant'
		@keyword					= params["keyword"]   || nil
		@radius						= to_meters(params["radius"])
		@latitude					= params["latitude"]  || nil
		@longitude					= params["longitude"] || nil
		@address					= geocode_address(params["address"]||nil)
		@fav_locations              = fav_locations.pluck(:location_id)
		@google_api_key 			= ENV['GOOGLE_PLACES_API_KEY']
		@google_nearby_places_url 	= ENV['GOOGLE_NEARBY_PLACES_URL']
	end

	def check_location
		unless has_location?
			errors.add(:base, 'Missing location in latitude/longitude or address.')
		end
	end

	def near_by
		query_obj = {
			"key": @google_api_key,
			"keyword": @keyword, 
			"type": @type, 
			"radius": @radius, 
			"location": "#@latitude, #@longitude"
		}
		errors = Errors.new()
		response = HTTParty.get(@google_nearby_places_url, query: query_obj)
		errors.handle_errors(response)
		return parse(response)
	end

	def has_location?
		if (@latitude.blank? || @longitude.blank?) && @address.blank?
			return false
		end
		return true
	end

	def to_meters(radius)
		return radius.to_f*1609.344.to_i
	end

	def geocode_address(address)
		return if address.blank?
		begin
			geo_response = Geocoder.search(address)
			coordinates = geo_response.first.coordinates
			@latitude = coordinates.first.to_s
			@longitude = coordinates.last.to_s
		rescue Exception #default
			@latitude = "33.70958615"
			@longitude = "-117.73722494017093"
		end
	end

	def parse(response)
		result = []
		if response["results"].blank?
			return result
		end

		response["results"].each do |entity|
			new_response_struct 					= response_struct
			new_response_struct[:location_id]		= entity["place_id"]
			new_response_struct[:business_status] 	= entity["business_status"]
			new_response_struct[:business_name]		= entity["name"]
			new_response_struct[:location]			= entity.fetch("geometry", {})["location"]
			new_response_struct[:image]				= entity["photos"].blank? ? nil : entity.fetch("photos").first["html_attributions"]
			new_response_struct[:address]			= entity["vicinity"]
			new_response_struct[:rating]			= entity["rating"]
			new_response_struct[:price_level]		= entity["price_level"]
			if @fav_locations.include? entity["place_id"]
				new_response_struct["is_favorite"] = true
			end 
			result.append(new_response_struct)
		end
		result
	end

	private

	def response_struct
		{
			"location_id": nil,
			"business_name": nil,
			"business_status": nil,
			"location": {},
			"address": nil,
			"image": nil,
			"is_favorite": false,
			"rating": nil,
			"price_level": nil
		}
	end


end