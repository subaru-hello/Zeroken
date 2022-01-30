module Api
  module V1
    class QuestionsController < BaseController
      def index
        @questions = Question.all
        render json: @questions
      end
    end
  end
end
