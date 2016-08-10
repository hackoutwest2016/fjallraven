class GamesController < ApplicationController
  def show
    @game = Game.find_by(init_player_slug: params[:id]) || Game.find_by(guest_player_slug: params[:id])
    if Game.find_by(init_player_slug: params[:id])
      @starting_player = false
      @player_artist = @game.artists.find_by(spotify_artist_id: @game.init_player_id)
    else
      @starting_player = true
      @player_artist = @game.artists.find_by(spotify_artist_id: @game.guest_player_id)
    end
    @player_slug = params[:id]
    @trivia = ArtistTriviaService.call(@player_artist.name)
  end

  def new
  end

  def create
    parsed_uri = parse_uri(params["playlist_uri"])
    @game = GameCreatorService.new.call(parsed_uri[:user], parsed_uri[:id])

    if @game.save
      redirect_to "/games/share/#{@game.init_player_slug}"
    else
      render :new
    end
  rescue RestClient::ResourceNotFound
    flash[:alert] = "Cound't find playlist"
    render :new
  end

  def share
    @game = Game.find_by(init_player_slug: params[:id])
  end

  private

  def parse_uri(uri)
    if web_url?(uri)
      { user: uri.split(":")[2], id: uri.split(":").last }
    else
      { user: uri.split("/")[4], id: uri.split("/").last }
    end
  end

  def web_url?(uri)
    uri.split("/")[1] != ""
  end
end
