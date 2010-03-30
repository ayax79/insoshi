class AddArtistToPhoto < ActiveRecord::Migration
  def self.up
    add_column :photos, :artist_id, :integer
  end

  def self.down
    remove_column :photos, :artist_id
  end
end
