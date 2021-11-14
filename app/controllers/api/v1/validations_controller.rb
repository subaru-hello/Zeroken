module Api
  module V1
    class ValidationsController < ApplicationController
      def unique
        users = User.where(id: params[:id]).where('nickname = ? or email= ?', params[:nickname], params[:email])
        result = users.exists? ? 'exist' : 'unique'
        render json: { mata: result }
      end
    end
  end
end
