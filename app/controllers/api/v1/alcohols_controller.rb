module Api
  module V1
    class AlcoholsController < ApplicationController
      def new
        Alcohol.new
      end

      def index
        @weak_alcohols = Alcohol.all.random_weak.order(id: "DESC")
        @strong_alcohols = Alcohol.all.random_strong.order(id: "DESC")
        respond_to do |format|
          format.json  { render :json => {:weak_alcohols => @weak_alcohols , 
                                          :strong_alcohols => @strong_alcohols}}
        end
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
