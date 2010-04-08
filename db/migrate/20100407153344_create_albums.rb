class CreateAlbums < ActiveRecord::Migration
  def self.up
    create_table :albums do |t|
      t.string :title
      t.integer :artist_id
      t.integer :size
      t.string :content_type
      t.string :filename
      t.integer :height
      t.integer :width
      t.string :thumbnail
      t.timestamps
    end
  end

  def self.down
    drop_table :albums
  end
end
