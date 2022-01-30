module Api
  module V1
    class AlcoholsController < BaseController
      def new
        Alcohol.new
      end

      def index
        alcohols = current_user.analyze_results.pluck[-1][-4..]
        @shuchedules = alcohols.map { |num| Alcohol.find(num) }

        respond_to { |format| format.json { render json: @shuchedules, methods: [:image_url] } }
      end

      def create
        @alcohol = Alcohol.build(alcohol_params)
        if alcohol.save
          render json: @alcohol, status: :created, methods: [:image_url]
        else
          render json: @alcohol.errors.full_messages, status: :bad_request
        end
      end

      private

      def alcohol_params
        params
          .require(:alcohol)
          .permit(:alcohol_percentage, :alcohol_amount, :name, :description, :image)
      end
    end
  end
end
