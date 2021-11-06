module Api
  module V1
    class AlcoholsController < ApplicationController
      def new
        Alcohol.new
      end

      def index
        @alcohols = Alcohol.all
        render json: @alcohols
      end

      def create
        @alcohol = Alcohol.build(alcohol_params)
        if alcohol.save
          render json: @alcohol, status: :created
        else
          render json: @alcohol.errors.full_messages, status: :bad_request
        end
      end

      private

      def alcohol_params
        params
          .require(:alcohol)
          .permit(:type, :alcohol_percentage, :alcohol_amount, :name, :description, :pure_alcohol_intake)
      end
    end
  end
end
