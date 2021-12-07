module Api
  module V1
    class UsersController < ApplicationController
      def index
        users = User.all
        render json: users
      end

      def create
        user = User.new(params_user)
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

      # def me
      #   render json: current_user, methods: [:avatar_url]
      # end

      private

      def params_user
        params.require(:user).permit(:nickname, :email, :password, :password_confirmation, :avatar)
      end
    end
  end
end
