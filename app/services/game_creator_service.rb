class GameCreatorService
  def initialize
    RSpotify.authenticate(ENV['spotify_id'], ENV['spotify_secret'])
  end

  def call(user_id, playlist_id)
    @user_id = user_id
    @playlist_id = playlist_id
    randomized_artists = randomize_player_artists(image_urls)

    Game.create(artists: image_urls,
                init_player_id: randomized_artists[:init_player],
                guest_player_id: randomized_artists[:guest_player])
  end

  private

  def image_urls
    image_urls = []
    tracks.each do |track|
      artist = track.artists.first
      artist_name = artist.name
      next if image_urls.map(&:name).include?(artist_name)
      image_urls << Artist.new(name: artist_name,
                               spotify_artist_id: artist.id,
                               image_url: artist.images.first['url'],
                               preview_url: track.preview_url,
                               spotify_track_id: track.id)
      break if image_urls.count == 24
    end
    image_urls
  end

  def tracks
    @tracks ||= RSpotify::Playlist.find(@user_id, @playlist_id).tracks
  end

  def randomize_player_artists(artists)
    init_player_artist = artists.sample
    { init_player: init_player_artist.spotify_artist_id,
      guest_player: (artists - [init_player_artist]).sample.spotify_artist_id }
  end
end
