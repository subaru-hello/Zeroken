module Api
  module V1
    class ProfilesController < UsersController
      before_action :require_login
      def update
        if current_user.update(profile_params)
          json_string = UserSerializer.new(current_user).serializable_hash
          render json: json_string
        else
          head :bad_request
        end
      end

      def edit
        @user = User.find(current_user.id)
      end

      def password
        if current_user.update(profile_params)
          json_string = UserSerializer.new(current_user).serializable_hash
          render json: json_string
        else
          head :bad_request
        end
      end

      private

      def profile_params
        # params[:data][:user][:avatar] = uploadedfile_create(params[:data][:user][:avatar])
        params.require(:profile).permit(:nickname, :email, :password, :password_confirmation)
      end
    end
  end
end
