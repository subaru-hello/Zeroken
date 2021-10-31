module Api::V1
  class UsersController < ApplicationController
    def index
      users = User.all
      render json: users
    end
    def create
      user = User.new(set_user)
      if user.save
        auto_login(user)
        json_string = UserSerializer.new(user).serializable_hash.to_json
        render json: json_string
      else
        head :bad_request
      end
    end

    def tell_on
      if current_user
        json_string = UserSerializer.new(current_user).serializable_hash.to_json
        render json: json_string
      else
        render json: nil
      end
    end

    private

    def set_user
      params.require(:user).permit(:nickname, :email, :password, :password_confirmation)
    end
  end
end
