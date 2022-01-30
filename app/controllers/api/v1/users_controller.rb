module Api
  module V1
    class UsersController < BaseController
      before_action :set_users, only: %i[show edit update]
      def index
        @users = User.all
        render json: @users
      end

      def edit
        render json: @user
      end

      def show
        render json: @user
      end

      def create
        @user = User.new(params_user)
        if @user.save
          set_access_token!(@user)
          auto_login(@user)
          json_string = UserSerializer.new(@user).serializable_hash.to_json
          render json: json_string
        else
          render400(nil, @user.errors.full_messages)
        end
      end

      def update
        if @user.update(params_user)
          json_string = UserSerializer.new(current_user).serializable_hash
          render json: json_string
        else
          head :bad_request
        end
      end

      def me
        if current_user
          json_string = UserSerializer.new(current_user).serializable_hash.to_json
          render json: json_string
        else
          render json: nil
        end
      end

      private

      def set_users
        @user = User.find(params[:id])
      end

      def params_user
        params
          .require(:user)
          .permit(:id, :nickname, :email, :password, :password_confirmation, :avatar)
      end
    end
  end
end
