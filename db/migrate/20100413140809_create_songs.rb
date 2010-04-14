class CreateSongs < ActiveRecord::Migration
  def self.up
    create_table :songs do |t|
      t.string :title
      t.integer :album_id
      t.integer  :artist_id
      t.integer  :size
      t.string   :content_type
      t.string   :filename
      t.integer  :height
      t.integer  :width
      t.string   :thumbnail
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :position
      t.timestamps
    end
  end

  def self.down
    drop_table :songs
  end
end
