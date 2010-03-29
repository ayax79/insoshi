class AddArtistToGallery < ActiveRecord::Migration
  def self.up
    add_column :galleries, :artist_id, :integer 
  end

  def self.down
    remove_column :galleries, :artist_id
  end
end
