class GamesController < ApplicationController
  def show
    @game = Game.find(params[:id])
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
