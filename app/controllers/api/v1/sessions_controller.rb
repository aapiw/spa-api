class Api::V1::SessionsController < ApplicationController	
	
	skip_before_action :authenticate_token, only: [:create]

	def create
		@user = User.where(email: params[:email]).first
		
		if @user&.valid_password?(params[:password])
      jwt = JWT.encode(
        {user_id: @user.id, exp: (Time.now + 2.weeks).to_i},
        Rails.application.secrets.secret_key_base,
        'HS256'
      )
			render :create, status: :created, locals: { token: jwt }
		else
			render json: {success: false, status: :unauthorized, message: "Invalid email or password"}
		end
	end
	
	def destroy
		binding.pry
	  @current_user&.authentication_token = nil
	  if @current_user&.save
	    head(:ok)
	  else
	    head(:unauthorized)
	  end
	end

end