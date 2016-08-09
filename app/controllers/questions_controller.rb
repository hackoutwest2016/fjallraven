class QuestionsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_action :set_game

  def create
    QuestionsChannel.broadcast_to(@game, broadcast_params)
    render json: params
  end

  private

  def broadcast_params
    {
      msg: params[:msg],
      type: params[:type],
      slug: params[:slug]
    }
  end

  def set_game
    @game = Game.find(params[:id])
  end
end
