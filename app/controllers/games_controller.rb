class GamesController < ApplicationController
  def show
  end

  def create
    GameCreatorService.new.call('wayoutwestfestival', '1VkQ6nbfU4gKjsPjqwE2kZ')
  end
end
