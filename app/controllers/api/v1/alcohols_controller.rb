module Api
  module V1
    class AlcoholsController < ApplicationController
      def new
        Alcohol.new
      end

      def index
        alcohols = Alcohol.all
        alcohols_names = alcohols.map { |alcohol| alcohol.liquors }
        alcohols_json = {}
        alcohols_names.each_with_index do |name, index|
          json_key = "alcohols_#{index + 1}"
          alcohols_json[json_key] = name
        end
        respond_to { |format| format.json { render json: alcohols_json } }
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
          .permit(
            :type,
            :alcohol_percentage,
            :alcohol_amount,
            :name,
            :description,
            :pure_alcohol_intake
          )
      end
    end
  end
end
