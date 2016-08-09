class GamesController < ApplicationController
  def show
    @game = Game.find(params[:id])
    @artists = []
    24.times do 
      @artists.push({name:"David Bowie", image_url:"http://www.vogue.com/wp-content/uploads/2016/01/11/bowie-2.jpg", preview_url:"", spotify_track_id:"" })
    end
  end

  def create
    GameCreatorService.new.call('wayoutwestfestival', '1VkQ6nbfU4gKjsPjqwE2kZ')
  end
end
