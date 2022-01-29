module Api
  module V1
    class AnalyzeResultsController < BaseController
      before_action :set_analyze_result, only: %i[show edit update]

      # before_action :authenticate
      def new
        AnalyzeResultForm.new
      end

      def index
        @answers = current_user.analyze_results

        render json: @answers
      end

      def show
        render json: @analyze_result
      end

      def edit
        render json: @analyze_result
      end

      def create
        next_motivation = analyze_result_params['next_motivation']
        weight = analyze_result_params['weight']

        user_id = current_user.id
        total_point = AnalyzeResult.caluculate_total_point(user_id)
        description = AnalyzeResult.extract_description(total_point)
        alcohol_strongness = AnalyzeResult.caluculate_alcohol_strongness(total_point)
        total_alcohol_amounts =
          AnalyzeResult.calculate_total_alcohol_amount(weight, alcohol_strongness, next_motivation)
        alcohols = Alcohol.sum_amount(total_alcohol_amounts)
        shuchedule = alcohols.map(&:sample)
        caluculated_result = {
          user_id: user_id,
          next_motivation: next_motivation,
          description: description,
          alcohol_strongness: alcohol_strongness,
          total_alcohol_amounts: total_alcohol_amounts,
          first_alcohol: shuchedule[0]['id'],
          second_alcohol: shuchedule[1]['id'],
          third_alcohol: shuchedule[2]['id'],
          forth_alcohol: shuchedule[3]['id']
        }
        @analyze_result = AnalyzeResult.new(caluculated_result)
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
