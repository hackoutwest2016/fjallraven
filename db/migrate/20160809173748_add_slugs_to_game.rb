class AddSlugsToGame < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :init_player_slug, :string
    add_index :games, :init_player_slug
    add_column :games, :guest_player_slug, :string
    add_index :games, :guest_player_slug
  end
end
