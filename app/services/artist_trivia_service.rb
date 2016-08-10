class ArtistTriviaService
  def self.call(*args)
    @@client ||= Lastfm.new(ENV['lastfm_id'], ENV['lastfm_secret'])
    new(*args).call
  end

  def initialize(artist_name)
    @artist_name = artist_name
  end

  def call
    @response ||= @@client.artist.get_info(artist: @artist_name)
  end
end
