class Api::AlcoholsController < ApplicationController
  def new
    Alcohol.new
  end
  def create
    alcohol = Alcohol.new
  end

  private

  def set_analyze
    params
      .require(:alcohol)
      .permit(:alcohol_types, :alcohol_percentage, :description, :title, :description)
  end
end
