class AddPlayersToGame < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :init_player_id, :string
    add_column :games, :guest_player_id, :string
  end
end
