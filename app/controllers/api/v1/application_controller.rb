class Api::V1::ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  before_action :authenticate_api_user

  private

  def authenticate_api_user
    return render json: { error: 'Authentication Failed' }, status: 500 unless params.fetch(:user, nil)

    user_params = params.require(:user).permit(:email, :password)

    user = User.find_by_email(user_params[:email])

    @user = user if user.valid_password?(user_params[:password])

    return render json: { error: 'Authentication Failed' }, status: 500 unless @user
  end
end
