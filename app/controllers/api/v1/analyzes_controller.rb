class Api::V1::AnalyzesController < ApplicationController
  def new
    Analyze.new
  end
  def index
    @analyzes = Analyze.all
    render json: @analyzes
  end
  def show
    @analyzes = Analyze.all
    render json: @analyzes
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

  private

  def analyze_params
    params.require(:analyze).permit(:total_points, :drunk_types, :resistance_types)
  end
  def set_analyze
    @analyze = Analyze.find(params[:id])
  end
end
