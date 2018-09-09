class ApplicationController < ActionController::API
  respond_to :json

  # before_action :current_user
  before_action :authenticate_token

  def authenticate_token
    render json: {success: false, status: :unauthorized, message: "No Authorization"} unless current_user.present?
  end

  def current_user
    begin
      @current_user ||= User.find(payload['user_id'])
    rescue Exception => e
      nil
    end
  end

  private

  def payload
    JWT.decode(params[:token], Rails.application.secrets.secret_key_base, true, { algorithm: 'HS256' }).first
  end
end
