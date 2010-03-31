class AddArtistToComment < ActiveRecord::Migration
  def self.up
    add_column :comments, :artist_id, :integer
  end

  def self.down
    remove_column :comments, :artist_id
  end
end
