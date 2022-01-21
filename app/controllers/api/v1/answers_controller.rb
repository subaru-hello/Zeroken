module Api
  module V1
    class AnswersController < BaseController
      include SumResult
      def index
        @answers = Answer.all
        render json: @answers
      end

      def create
        # フロントから13この回答が送られてくるから、配列に入れて保存する。

        @answers = Answer.all
        render json: @answers
      end
    end
  end
end
