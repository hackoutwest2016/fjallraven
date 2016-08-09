class CreateArtists < ActiveRecord::Migration[5.0]
  def change
    create_table :artists do |t|
      t.string :name
      t.string :spotify_artist_id
      t.string :image_url
      t.string :preview_url
      t.string :spotify_track_id
      t.belongs_to :game, index: true

      t.timestamps
    end
  end
end
