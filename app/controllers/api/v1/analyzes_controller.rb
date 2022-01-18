module Api
  module V1
    class AnalyzesController < BaseController
      # before_action :set_analyze, only: %i[show]
      before_filter :authenticate, except: [:new, :create]
      def new
        Analyze.new
      end

      def index
        @analyzes = current_user.analyzes
        render json: @analyzes
      end

      # def show
      #   render json: @analyze
      # end

      def create
        @analyze = current_user.analyzes.new(analyze_params)
        if @analyze.save
          render json: @analyze, status: :created
        else
          render json: @analyze.errors.full_messages, status: :bad_request
        end
      end

      private

      def analyze_params
        params
          .require(:analyze)
          .permit(:total_points, :alcohol_strongness, :next_motivation, :description, :shuchedule)
          .merge(user_id: current_user.id)
      end

      # def set_analyze
      #   @analyze = Analyze.find_by(id: params[:id])
      # end
    end
  end
end
