class AddFacebookIdToArtistPeople < ActiveRecord::Migration
  def self.up
    add_column :people, :facebook_id, :integer
    add_column :artists, :facebook_id, :integer
  end

  def self.down
    remove_column :people, :facebook_id
    remove_column :artists, :facebook_id
  end
end
