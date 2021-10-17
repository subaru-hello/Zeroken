module Api
  class ValidationsController < ApplicationController
    def unique
      result =
        if User.where(nickname: params[:nickname]).or(User.where(email: params[:email])).exists?
          'exist'
        else
          'unique'
        end
      render json: result
    end
  end
end
