module Api
  module V1
    class AnalyzesController < ApplicationController
      before_action :set_analyze, only: %i[show update]
      def new
        Analyze.new
      end

      def index
        @analyzes = Analyze.all
        render json: @analyzes
      end

      def show
        render json: @analyze
      end

      def create
        @analyze = current_user.analyzes.new(analyze_params)
        if @analyze.save
          render json: @analyze, status: :created
          #   json_string = AnalyzeSerializer.new(@analyzes).serializable_hash.to_json
          #   render json: json_string
        else
          render json: @analyze.errors.full_messages, status: :bad_request
        end
      end

      def update
        if @analyze.update(analyze_params)
          render json: @analyze
        else
          render json: @analyze.errors, status: :bad_request
        end
      end

      private

      def analyze_params
        params
          .require(:analyze)
          .permit(
            :total_points,
            :sake_strongness_types,
            :next_nomivation_types,
            :description,
            :shuchedule
          )
      end

      def set_analyze
        @analyze = Analyze.find_by(id: params[:id])
      end
    end
  end
end
