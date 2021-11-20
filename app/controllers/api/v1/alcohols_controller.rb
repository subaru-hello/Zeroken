module Api
  module V1
    class AlcoholsController < ApplicationController
      def new
        Alcohol.new
      end

      def index
        #純アルコール量が0~14、それかビールしか入れない。また、「お酒を飲んではいけない人」になった場合はソフトドリンクしか勝たんモードに入る
        @semi_weaks = Alcohol.all.semi_weak.selected.sort_by { |a| a[:alcohol_percentage] }

        #純アルコール量が0.1~15
        @weaks = Alcohol.all.weak.selected.sort_by { |a| a[:alcohol_percentage] }

        #純アルコール量が
        @semi_strongs = Alcohol.all.semi_strong.selected.sort_by { |a| a[:alcohol_percentage] }
        @strongs = Alcohol.all.strong.selected.sort_by { |a| a[:alcohol_percentage] }

        respond_to do |format|
          format.json do
            render json: {
                     first_orders: @semi_weaks,
                     second_orders: @weaks,
                     third_orders: @semi_strongs,
                     forth_orders: @strongs
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
