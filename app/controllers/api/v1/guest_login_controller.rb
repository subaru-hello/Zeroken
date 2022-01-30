module Api
  module V1
    class GuestLoginController < BaseController
      # before_filter :authenticate, except: [:new, :create]
      def create
        user = User.find_by!(role: :guest)
        set_access_token!(user)
        auto_login(user)
        json_string = UserSerializer.new(user).serializable_hash.to_json
        render json: json_string
      end
    end
  end
end
