class GamesController < ApplicationController
  def show
    @game = Game.find(params[:id])
    @artists = []
    24.times do
      @artists.push({name:"David Bowie", image_url:"http://www.vogue.com/wp-content/uploads/2016/01/11/bowie-2.jpg", preview_url:"", spotify_track_id:"" })
    end
  end

  def new
  end

  def create
    parsed_uri = parse_uri(params["playlist_uri"])
    GameCreatorService.new.call(parsed_uri[:user], parsed_uri[:id])
  end

  private

  def parse_uri(uri)
    { user: uri.split(":")[2], id: uri.split(":").last }
  end
end
