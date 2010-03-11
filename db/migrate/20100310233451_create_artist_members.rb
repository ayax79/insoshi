class CreateArtistMembers < ActiveRecord::Migration

  def self.up
    drop_table :artists_members
    create_table :artist_members do |t|
      t.integer :artist_id
      t.integer :person_id
      t.string :description
      t.timestamps
    end
  end

  def self.down
    drop_table :artist_members
    create_table :artists_members, :id => false do |t|
      t.integer :artist_id
      t.integer :person_id
    end
  end

end
