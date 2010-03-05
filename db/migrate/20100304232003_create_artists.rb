class CreateArtists < ActiveRecord::Migration
  def self.up
    create_table :artists_fans do |t|
      t.integer :artist_id
      t.integer :person_id 
      t.timestamps
    end
    create_table :artists_members do |t|
      t.integer :artist_id
      t.integer :person_id
      t.timestamps
    end
    create_table :artists do |t|
      t.string :name, :null => false, :unique => true
      t.text :bio
      t.timestamps
    end
  end

  def self.down
    drop_table :artists_fans
    drop_table :artists_members
    drop_table :artists
  end
end
