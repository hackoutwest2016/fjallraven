class ArtistTriviaService
  def self.call(*args)
    @@client ||= Lastfm.new(ENV['lastfm_id'], ENV['lastfm_secret'])
    new(*args).call
  end

  def initialize(artist_name)
    @artist_name = artist_name
  end

  def call
    get_info
  end

  def get_info
    @response ||= @@client.artist.get_info(artist: @artist_name)
    @response
  end
end
