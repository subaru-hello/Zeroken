module Api
  module V1
    class AuthenticationsController < BaseController
      skip_before_action :authenticate
      def create
        @user = login(params[:email], params[:password])

        raise ActiveRecord::RecordNotFound unless @user

        set_access_token!(@user)

        json_string = UserSerializer.new(@user).serialized_json
        render json: json_string
      end
    end
  end
end
