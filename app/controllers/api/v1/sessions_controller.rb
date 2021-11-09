module Api
  module V1
    class SessionsController < ApplicationController
      skip_before_action :require_login, only: %i[ create guest_login]
      def create
        # binding.pry
        @user = login(params[:email], params[:password])
        #
        if @user
          json_string = UserSerializer.new(@user).serializable_hash.to_json
          render json: json_string
        else
          head :unauthorized
        end
      end

      def destroy
        logout
        head :ok
      end

      def guest_login
        user = User.find_by!(role: :guest)
        auto_login(user)
           json_string = UserSerializer.new(user).serializable_hash.to_json
          render json: json_string
      end
    end
  end
end
