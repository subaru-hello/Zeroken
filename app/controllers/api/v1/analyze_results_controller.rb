module Api
  module V1
    class AnalyzeResultsController < BaseController
      before_action :set_analyze_result, only: %i[show]

      # before_action :authenticate
      def new
        AnalyzeResultForm.new
      end

      def index
        @answers = current_user.analyze_results
        render json: @answers
      end

      def show
        render json: @analyze_results
      end

      def create
        next_motivation = analyze_result_params['next_motivation']
        weight = analyze_result_params['weight']

        user_id = current_user.id

        description = AnalyzeResult.new.extract_description(user_id)
        alcohol_strongness = AnalyzeResult.new.caluculate_alcohol_strongness(user_id)
        total_alcohol_amounts =
          AnalyzeResult.new.calculate_total_alcohol_amount(
            weight,
            alcohol_strongness,
            next_motivation
          )
        alcohols = Alcohol.new.sum_amount(total_alcohol_amounts)
        shuchedule = alcohols.map { |arr| arr.sample }
        binding.pry
        caluculated_result = {
          user_id: user_id,
          next_motivation: next_motivation,
          description: description,
          alcohol_strongness: alcohol_strongness,
          total_alcohol_amounts: total_alcohol_amounts,
          first_alcohol: shuchedule[0],
          second_alcohol: shuchedule[1],
          third_alcohol: shuchedule[2],
          forth_alcohol: shuchedule[3]
        }

        # binding.pry
        @analyze_result = AnalyzeResult.new(caluculated_result)
        binding.pry
        if @analyze_result.save
          render json: @analyze_result, status: :created
        else
          render json: @analyze_result.errors.full_messages, status: :bad_request
        end
      end

      def update
        @analyze_result = AnalyzeResult.find(params[:id])
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
        @analyze_result = AnalyzeResult.find_by(id: params[:id])
      end
    end
  end
end
