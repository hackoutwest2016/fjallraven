class GameCreatorService
  def initialize
    RSpotify.authenticate(ENV['spotify_id'], ENV['spotify_secret'])
  end

  def call(user_id, playlist_id)
    @user_id = user_id
    @playlist_id = playlist_id

    Game.create(artists: image_urls.uniq)
  end

  private

  def image_urls
    image_urls = []
    tracks.each do |track|

      artist = track.artists.first
      artist_name = artist.name
      next if image_urls.map(&:name).include?(artist_name)
      image_urls << OpenStruct.new(name: artist_name,
                                   image_url: artist.images.first['url'],
                                   preview_url: track.preview_url,
                                   spotify_track_id: track.id)
    end
    image_urls
  end

  def tracks
    @tracks ||= RSpotify::Playlist.find(@user_id, @playlist_id).tracks
  end
end
