module Api
  module V1
    class DescriptionsController < BaseController
      def index
      @description = Description.all
      render json: @description
      end
    end
  end
end
