class AddArtistToBlog < ActiveRecord::Migration
  def self.up
    add_column :blogs, :artist_id, :integer
  end

  def self.down
    remove_column :blogs, :artist_id
  end
end
