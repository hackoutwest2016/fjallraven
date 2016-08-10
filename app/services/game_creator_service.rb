class GameCreatorService
  def initialize
    RSpotify.authenticate(ENV['spotify_id'], ENV['spotify_secret'])
  end

  def call(uri)
    @uri = uri
    @parsed_uri = parse_uri(@uri)
    @user_id = @parsed_uri[:user]
    @playlist_id = @parsed_uri[:id]
    @artists = artists
    randomized_artists = randomize_player_artists(@artists)

    Game.new(playlist_uri: uri,
             artists: @artists,
             init_player_id: randomized_artists[:init_player],
             guest_player_id: randomized_artists[:guest_player])
  end

  private

  def artists
    artists = []
    tracks.each do |track|
      artist = track.artists.first
      artist_name = artist.name
      next if artists.map(&:name).include?(artist_name)
      artists << Artist.new(name: artist_name,
                            spotify_artist_id: artist.id,
                            image_url: artist.images.first['url'],
                            preview_url: track.preview_url,
                            spotify_track_id: track.id)
      break if artists.count == 24
    end
    artists
  end

  def tracks
    @tracks ||= RSpotify::Playlist.find(@user_id, @playlist_id).tracks
  end

  def randomize_player_artists(artists)
    init_player_artist = artists.sample
    { init_player: init_player_artist.spotify_artist_id,
      guest_player: (artists - [init_player_artist]).sample.spotify_artist_id }
  end

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
