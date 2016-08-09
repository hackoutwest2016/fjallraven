class AddArtistsToGame < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :artists, :text
  end
end
