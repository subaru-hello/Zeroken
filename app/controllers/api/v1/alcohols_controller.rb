module Api
  module V1
    class AlcoholsController < ApplicationController
      def new
        Alcohol.new
      end

      def index
        # TODO: 要リファクタリング
        @alcohols_1 = Alcohol.find(1).liquors
        @alcohols_2 = Alcohol.find(2).liquors
        @alcohols_3 = Alcohol.find(3).liquors
        @alcohols_4 = Alcohol.find(4).liquors
        @alcohols_5 = Alcohol.find(5).liquors
        @alcohols_6 = Alcohol.find(6).liquors
        @alcohols_7 = Alcohol.find(7).liquors
        @alcohols_8 = Alcohol.find(8).liquors
        @alcohols_9 = Alcohol.find(9).liquors
        @alcohols_10 = Alcohol.find(10).liquors
        @alcohols_11 = Alcohol.find(11).liquors
        @alcohols_12 = Alcohol.find(12).liquors
        @alcohols_13 = Alcohol.find(13).liquors
        @alcohols_14 = Alcohol.find(14).liquors
        @alcohols_15 = Alcohol.find(15).liquors
        @alcohols_16 = Alcohol.find(16).liquors
        @alcohols_17 = Alcohol.find(17).liquors
        @alcohols_18 = Alcohol.find(18).liquors
        @alcohols_19 = Alcohol.find(19).liquors
        @alcohols_20 = Alcohol.find(20).liquors
        @alcohols_21 = Alcohol.find(21).liquors
        @alcohols_22 = Alcohol.find(22).liquors
        @alcohols_23 = Alcohol.find(23).liquors
        respond_to do |format|
          format.json do
            render json: {
              alcohols_1: @alcohols_1,
              alcohols_2: @alcohols_2,
              alcohols_3: @alcohols_3,
              alcohols_4: @alcohols_4,
              alcohols_5: @alcohols_5,
              alcohols_6: @alcohols_6,
              alcohols_7: @alcohols_7,
              alcohols_8: @alcohols_8,
              alcohols_9: @alcohols_9,
              alcohols_10: @alcohols_10,
              alcohols_11: @alcohols_11,
              alcohols_12: @alcohols_12,
              alcohols_13: @alcohols_13,
              alcohols_14: @alcohols_14,
              alcohols_15: @alcohols_15,
              alcohols_16: @alcohols_16,
              alcohols_17: @alcohols_17,
              alcohols_18: @alcohols_18,
              alcohols_19: @alcohols_19,
              alcohols_20: @alcohols_20,
              alcohols_21: @alcohols_21,
              alcohols_22: @alcohols_22,
              alcohols_23: @alcohols_23
            }
          end
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
