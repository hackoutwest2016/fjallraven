class QuestionsController < ApplicationController
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
