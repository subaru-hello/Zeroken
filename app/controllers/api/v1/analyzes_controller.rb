module Api
  module V1
    class AnalyzesController < ApplicationController
      before_action :set_analyze, only: %i[show update]
      def new
        Analyze.new
      end

      # current_user.analyzes.allの場合(6.7ms)
      # User Load (4.0ms)  SELECT `users`.* FROM `users` ORDER BY `users`.`id` ASC LIMIT 1
      # Analyze Load (2.7ms)  SELECT `analyzes`.* FROM `analyzes` WHERE `analyzes`.`user_id` = 1

      # current_user.analyzes.includes(:user)の場合(1.7ms)
      # User Load (1.3ms)  SELECT `users`.* FROM `users` ORDER BY `users`.`id` ASC LIMIT 1
      # Analyze Load (0.4ms)  SELECT `analyzes`.* FROM `analyzes` WHERE `analyzes`.`user_id` = 1
      def index
        @analyzes = current_user.analyzes.includes(:user)
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
          .permit(:total_points, :alcohol_strongness, :next_motivation, :description, :shuchedule)
      end

      def set_analyze
        @analyze = Analyze.find_by(id: params[:id])
      end
    end
  end
end
