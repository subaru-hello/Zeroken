class Api::V1::AlcoholsController < ApplicationController
  def new
    Alcohol.new
  end
  def create
    alcohol = Alcohol.build(alcohol_params)
    if alcohol.save
      render json: alcohol, status: :created
    else
      render json: alcohol.errors.full_messages, status: :bad_request
    end
  end

  private

  def alcohol_params
    params
      .require(:alcohol)
      .permit(:alcohol_types, :alcohol_percentage, :description, :title, :description)
  end
end
