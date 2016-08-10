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
    @game = GameCreatorService.new.call(params["playlist_uri"])

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
end
