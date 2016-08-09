class GamesController < ApplicationController
  def show
    @game = Game.find(params[:id])
  end

  def create
    GameCreatorService.new.call('wayoutwestfestival', '1VkQ6nbfU4gKjsPjqwE2kZ')
  end
end
