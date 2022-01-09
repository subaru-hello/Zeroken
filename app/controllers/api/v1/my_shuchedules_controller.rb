module Api
  module V1
    class MyShuchedulesController < BaseController
      before_action :authenticate
      def new
        MyShuchedule.new
      end

      def index
        current_user_id = current_user.id
        @shuchedule = MyShuchedule.find_by(user_id: current_user_id)
        render json: @shuchedule
      end

      def create
        # user = User.find_by(id: params[:id])
        @shuchedule = MyShuchedule.new(shuchedule_params)
        if @shuchedule.save
          render json: @shuchedule, status: :created
          # json_string = MyShuchedule.new(@shuchedule).serializable_hash.to_json
          # render json: json_string
        else
          render json: @shuchedule.errors.full_messages, status: :bad_request
        end
      end

      private

      def shuchedule_params
        params
          .require(:my_shuchedule)
          .permit(:succeed_shuchedule, :succeed_alcohol_strongness, :user_id)
      end
    end
  end
end
