class Api::V1::UsersController < ApplicationController
	before_action :set_user, only: [:show, :edit, :update, :destroy]
	skip_before_action :authenticate_token, only: [:create]
	# GET /users
	# GET /users.json
	def index
		if params["filters"]&.select{|k,v| v.present?}.present?
			@users = User.filter_users(params["filters"], params[:page])
		else
			@users = User.page(params[:page]).per(5)
		end
		render :index
	end

	# GET /users/1
	# GET /users/1.json
	def show;end

	# GET /users/new
	def new
	  @user = User.new
	end

	# GET /users/1/edit
	def edit; end

	# POST /users
	# POST /users.json
	def create
		@user = User.new(user_params)
		if @user.save
			render :create
		else
			render json: {success:false, code: 422, message: @user.errors.full_messages, status: :unprocessable_entity}
			# head(:unprocessable_entity)
		end
	end

	# PATCH/PUT /users/1
	# PATCH/PUT /users/1.json
	def update
		if @user.update(user_params)
			render :create
		else
			render json: {success:false, code: 422, message: @user.errors.full_messages, status: :unprocessable_entity}
		end
	end

	# DELETE /users/1
	# DELETE /users/1.json
	def destroy
		if @user.destroy
			render json: {success:true, code: 200, message:"User was successfully destroyed."}
		end
	end

	private
	def set_user
		@user = User.find(params[:id])
	end

	def user_params
		params.require(:user).permit(:email, :password, :password_confirmation)
	end

end