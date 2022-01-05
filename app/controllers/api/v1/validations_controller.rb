module Api
  module V1
    class ValidationsController < BaseController
      def unique
        users = User.where('nickname = ? or email = ?', params[:nickname], params[:email])
        result = users.exists? ? 500 : 200
        render json: result
      end
    end
  end
end
