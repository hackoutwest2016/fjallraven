class QuestionsChannel < ActionCable::Channel
  def subscribed
    game = Game.find(params[:id])
    stream_for game
  end
end
