module Api
  module V1
    class AlcoholInVeinsController < BaseController
      def index
        @alcohol_in_veins = AlcoholInVein.all
        render json: @alcohol_in_veins
      end

      def create
        @alcohol_in_veins = AlcoholInVein.all

        render json: @alcohol_in_veins
      end
    end
  end
end
