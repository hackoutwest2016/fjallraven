class QuestionsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_action :set_game

  def create
    QuestionsChannel.broadcast_to(@game, params[:msg])
    render json: params
  end

  private

  def set_game
    @game = Game.find(params[:id])
  end
end
