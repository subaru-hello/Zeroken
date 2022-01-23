module Api
  module V1
    class TastAnswersController < ApplicationController
      def index
        @tast_answers = current_user.tast_answers.includes(:user)
        render json: @tast_answers
      end

      def create
        @tast_answer = current_user.tast_answers.new(params_tast_answers)
        if @tast_answer.save
          render json: @tast_answer
        else
          puts @tast_answer.errors.full_messages
          render json: @tast_answer.errors.full_messages, status: :bad_request
        end
      end

      def show
        @tast_answer = TastAnswer.find(params[:id])
        render json: @tast_answer
      end

      private

      def params_tast_answers
        params
          .require(:tast_answer)
          .permit(
            :face_flush,
            :other_than_face_flush,
            :itchy,
            :dizy,
            :drowsy,
            :anxiety,
            :headache,
            :throbbing_headache,
            :sweating,
            :heartbeating,
            :nauseous,
            :chill,
            :breathless,
            :weight,
            :next_motivation
          )
      end
    end
  end
end
