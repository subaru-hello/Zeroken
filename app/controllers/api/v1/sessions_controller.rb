module Api
  module V1
    class SessionsController < ApplicationController
      before_action :require_login, only: :destroy
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
    end
  end
end
