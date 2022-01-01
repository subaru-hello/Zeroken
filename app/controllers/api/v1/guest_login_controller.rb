module Api
  module V1
    class GuestLoginController < ApplicationController
      def create
        user = User.find_by!(role: :guest)
        auto_login(user)
        json_string = UserSerializer.new(user).serializable_hash.to_json
        render json: json_string
      end
    end
  end
end
