module Api
  module V1
    class SessionsController < BaseController
      def create
        @user = login(params[:email], params[:password])

        raise ActiveRecord::RecordNotFound unless @user

        set_access_token!(@user)

        json_string = UserSerializer.new(@user).serializable_hash.to_json
        render json: json_string
      end

      def destroy
        logout
        head :ok
      end
    end
  end
end
