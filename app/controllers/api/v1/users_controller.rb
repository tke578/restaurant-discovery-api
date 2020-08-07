class Api::V1::UsersController < ApplicationController
	before_action :is_authorized
	skip_before_action :is_authorized, only: [:create, :login]

	def index
		render json: {"Hello": "World!"}
	end

	def create
		@user = User.create(user_params)
		if @user.valid?
			token = encode_token({user_id: @user.id})
			render json: {user_email: @user.email, token: token}
		else
			error_msg = @user.errors.full_messages.blank? ? 'Invalid email and/or password.' : @user.errors.full_messages.join(",")
			render json: {error: error_msg}, status: :bad_request
		end
	end

	def login
	    @user = User.find_by(email: params[:email])
	    if @user && @user.authenticate(params[:password])
	      token = encode_token({user_id: @user.id})
	      render json: {user_email: @user.email, token: token}
	    else
	      render json: {error: 'Invalid email and/or password.'}, status: :bad_request
	    end
  	end

	private 

	def user_params
		params.permit(:email, :password)
	end
end
