class GamesController < ApplicationController
  def show
    @game = Game.find_by(init_player_slug: params[:id]) || Game.find_by(guest_player_slug: params[:id])
    @artists = @game.artists
  end

  def new
  end

  def create
    parsed_uri = parse_uri(params["playlist_uri"])

    @game = GameCreatorService.new.call(parsed_uri[:user], parsed_uri[:id])
    if @game.save
      redirect_to @game
    else
      render :new
    end
  rescue RestClient::ResourceNotFound
    flash[:alert] = "Cound't find playlist"
    render :new
  end

  private

  def parse_uri(uri)
    { user: uri.split(":")[2], id: uri.split(":").last }
  end
end
