module Api
  class UsersController < ApplicationController
    def create
      user = User.new(set_user)
      if user.save
        head :ok
      else
        head :bad_request
      end
    end

    private

    def set_user
      params.require(:user).permit(:nickname, :email, :password, :password_confirmation)
    end
  end
end
