module Api
  module V1
    class AnswersController < BaseController
      # include SumResult
      def index
        @answers = Answer.all
        render json: @answers
      end
    end
  end
end
