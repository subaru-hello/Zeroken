module Api
  module V1
    class QuestionsController < BaseController
      def index
      @questions = Question.all
      render json: @question
      end
    end
  end
end
