class GameCreatorService
  def initialize
    RSpotify.authenticate(ENV['spotify_id'], ENV['spotify_secret'])
  end

  def call(user_id, playlist_id)
    @user_id = user_id
    @playlist_id = playlist_id

    Game.create(artists: image_urls)
  end

  private

  def image_urls
    image_urls = {}
    artists.each do |artist|
      artist = artist.first
      image_urls.store(artist.name, artist.images.first['url'])
    end
    image_urls
  end

  def artists
    @artists ||= RSpotify::Playlist.find(@user_id, @playlist_id).tracks.map(&:artists)
  end
end
