class CreateArtistInvites < ActiveRecord::Migration
  def self.up
    create_table :artist_invites do |t|
      t.string :email
      t.integer :artist_id
      t.timestamps
    end
  end

  def self.down
    drop_table :artist_invites
  end
end
