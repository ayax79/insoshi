class CreateExternalCreds < ActiveRecord::Migration
  def self.up
    create_table :external_creds do |t|
      t.integer :person_id
      t.string :provider, :limit => 10
      t.string :username, :limit => 100
      t.string :identifier
      t.timestamps
    end
  end

  def self.down
    drop_table :external_creds
  end
end
