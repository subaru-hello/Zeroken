class Api::AnalyzesController < ApplicationController
  def new
    Analyze.new
  end
  def create
    analyze = Analyze.new
  end

  private

  def set_analyze
    params.require(:analyze).permit(:total_points, :drunk_types, :resistance_types)
  end
end
