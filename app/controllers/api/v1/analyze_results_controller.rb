module Api
  module V1
    class AnalyzeResultsController < BaseController
      before_action :set_analyze_result, only: %i[show edit update]

      def index
        @answers = current_user.analyze_results

        render json: @answers
      end

      def show
        render json: @analyze_result
      end

      # before_action :authenticate
      def new
        AnalyzeResultForm.new
      end

      def edit
        render json: @analyze_result
      end

      def create
        next_motivation = analyze_result_params['next_motivation']
        weight = analyze_result_params['weight']
        user_id = current_user.id
        calculated_result = AnalyzeResult.cal_shuchedule(weight, next_motivation, user_id)
        @analyze_result = AnalyzeResult.new(calculated_result)
        if @analyze_result.save
          render json: @analyze_result, status: :created
        else
          render json: @analyze_result.errors.full_messages, status: :bad_request
        end
      end

      def update
        if @analyze_result.update(analyze_result_params)
          render json: @analyze_result, status: :created
        else
          render json: @analyze_result.errors.full_messages, status: :bad_request
        end
      end

      private

      def analyze_result_params
        params
          .require(:analyze_result)
          .permit(
            :id,
            :weight,
            :next_motivation,
            :user_id,
            :alcohol_strongness,
            :description,
            :total_alcohol_amounts,
            :first_alcohol,
            :second_alcohol,
            :third_alcohol,
            :forth_alcohol
          )
      end

      def set_analyze_result
        @analyze_result = AnalyzeResult.find(params[:id])
      end
    end
  end
end
