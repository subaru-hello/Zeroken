module Api
  module V1
    class AlcoholsController < BaseController
      def new
        Alcohol.new
      end

      def index
        @alcohols = Alcohol.all
        #どのお酒をanalyzeResultに保存するのかかく
        total_alcohol_amounts = alcohol.alcohol_amount * alcohol.alcohol_percentage
        #scopeに0、1200、1500、4000などを定義し、それぞれの条件に該当するお酒をフロントに全て渡す。
        #フロント側で順番を変更し、AnalyzeResultに配列で渡し、AnalyzeResultは受け取った４つのお酒をalcohol_first,alcohol_second,alcohol_third,alcohol_forthに保存する　
        respond_to { |format| format.json { render json: @alcohols, methods: [:image_url] } }
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
          .permit(
            :alcohol_percentage,
            :alcohol_amount,
            :name,
            :description,
            :image
          )
      end
    end
  end
end
