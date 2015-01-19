class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.integer :album_id, null: false
      t.string :track_type, null: false
      t.text :lyrics

      t.timestamps
    end
  end
end
