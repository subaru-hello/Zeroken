module Api
  module V1
    class AnalyzeResultsController < BaseController
      before_action :set_analyze_result, only: %i[show]
      # before_action :authenticate
      def new
        AnalyzeResult.new
      end

      def index
        @analyze_results = current_user.analyze_results
        render json: @analyze_results
      end

      def show
        render json: @analyze_results
      end

      def create
        @analyze_result = current_user.analyze_results.new(analyze_result_params)
        if @analyze_result.save
          render json: @analyze_result, status: :created
        else
          render json: @analyze_result.errors.full_messages, status: :bad_request
        end
      end

      private

      def analyze_result_params
        params
          .require(:analyze_result)
          .permit(:total_points, :alcohol_strongness, :next_motivation, :total_alcohol_amounts, :alcohol_first, :alcohol_second, :alcohol_third, :alcohol_forth)
          .merge(user_id: current_user.id)
      end

      def set_analyze_result
        @analyze_result = AnalyzeResult.find_by(id: params[:id])
      end
    end
  end
end
