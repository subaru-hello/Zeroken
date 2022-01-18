module Api
  module V1
    class ProfilesController < BaseController
      def update
        if current_user.update(user_params)
          json_string = UserSerializer.new(current_user).serializable_hash
          render json: json_string
        else
          head :bad_request
        end
      end

      def edit
        # @user = User.find_by!(id: current_user.id)
        current_user.nickname = params[:nickname]
        current_user.email = params[:email]
        # render json: @user
      end

      def password
        current_user.password_confirmation = params[:password_confirmation]
        current_user.password = params[:password] ? head(:ok) : head(:bad_request)
      end

      private

      def user_params
        # params[:data][:user][:avatar] = uploadedfile_create(params[:data][:user][:avatar])
        params.require(:user).permit(:nickname, :email, :password, :password_confirmation)
      end
    end
  end
end
