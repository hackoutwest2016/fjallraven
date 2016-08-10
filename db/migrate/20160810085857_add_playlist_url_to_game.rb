class AddPlaylistUrlToGame < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :playlist_uri, :string
  end
end
