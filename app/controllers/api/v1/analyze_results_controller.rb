module Api
  module V1
    class AnalyzeResultsController < BaseController
      before_action :set_analyze_result, only: %i[show]
      # before_action :authenticate
      def new
        AnalyzeResult.new
      end

      def index
        @analyze_results = AnalyzeResult.all
        render json: @analyze_results
      end

      def show
        render json: @analyze_results
      end

      def create
        #配列にある数字をfind(i)という形で繰り返し処理を行い、answer_array.length ++で回す。その結果、配列にはpointが[-10,0.2,0.3,0.4,5.1]のように入る
        @answers_all = Answer.find_by(id: params[:id])
        # includeしたsumResultでさっき計算したarray_pointを全て足し合わせる
       a =  total_point(@answer_all)
        #足し合わせた合計値によって分岐させる処理を書く・酒の強さを5段階にして表す。
      b =   if a >2
          4
        elsif a > 1
          3
        elsif a = 0
          2
        elsif a < 0
          1
        else
          0
        end

        c = params[:next_motivation]
        @total_alcohol_amounts = params[:weigh] * coefficient * 
        @analyze_result = AnalyzeResult.new(analyze_result_params)
       
            #どのアルコール血中濃度をanalyzeに渡すかを定義する。多分これもconcern、もしくはAlcoholInVeinモデル
  @alcohol_in_vein =  if AnalyzeResult.find().alcohol_strongness == 4 && AnalyzeResult.find().alcohol_strongness == 0
      AlcholInVein.find(0)
          if AnalyzeResult.find().alcohol_strongness == 4 && AnalyzeResult.find().alcohol_strongness == 0
      AlcholInVein.find(1)
          if AnalyzeResult.find().alcohol_strongness == 4 && AnalyzeResult.find().alcohol_strongness == 0
      AlcholInVein.find(2)
          if AnalyzeResult.find().alcohol_strongness == 4 && AnalyzeResult.find().alcohol_strongness == 0
      AlcholInVein.find(3)
          if AnalyzeResult.find().alcohol_strongness == 4 && AnalyzeResult.find().alcohol_strongness == 0
      AlcholInVein.find(4)

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
          .permit(:total_points, :alcohol_strongness, :next_motivation, :total_alcohol_amounts, :alcohol_first, :alcohol_second, :alcohol_third, :alcohol_forth,:user_id, :alcohol_in_vein_id, :description_id)
      end

      def set_analyze_result
        @analyze_result = AnalyzeResult.find_by(id: params[:id])
      end
    end
  end
end
