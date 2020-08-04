class ApplicationController < ActionController::API

	def encode_token(data)
    	JWT.encode(data, ENV['JWT_SECRET'])
  	end

	def auth_header
    	if request.headers['Authorization'].blank?
    		return false
    	end
    	return request.headers['Authorization']
  	end

	def decoded_token
	    if auth_header
	      begin
	        JWT.decode(auth_header, ENV['JWT_SECRET'], true, algorithm: 'HS256')
	      rescue JWT::DecodeError
	        false
	      end
	    end
  	end


	def find_user
    	if decoded_token
      		user_id = decoded_token[0]['user_id']
      		@user = User.find_by(id: user_id)
    	end
  	end

	def user_logged_in?
		!!find_user
	end


	def is_authorized
		render json: {message: 'Please log in or create an account.'}, status: :unauthorized unless user_logged_in?
	end
end
