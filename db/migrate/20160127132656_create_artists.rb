class CreateArtists < ActiveRecord::Migration
  def change
    create_table :artists do |t|
      t.string  :full_name, null: false
      t.integer :soundcloud_id, null: false
      t.string  :avatar_url
      t.string  :permalink_url
      t.integer :track_count

      t.timestamps null: false
    end
  end
end
