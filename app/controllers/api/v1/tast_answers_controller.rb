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
            :selected_choices_0,
            :selected_choices_1,
            :selected_choices_2,
            :selected_choices_3,
            :selected_choices_4,
            :selected_choices_5,
            :selected_choices_6,
            :selected_choices_7,
            :selected_choices_8,
            :selected_choices_9,
            :selected_choices_10,
            :selected_choices_11,
            :selected_choices_12
          )
      end
    end
  end
end
