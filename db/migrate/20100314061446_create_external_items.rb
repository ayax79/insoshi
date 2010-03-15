class CreateExternalItems < ActiveRecord::Migration
  def self.up
    create_table :external_items do |t|
      t.integer :person_id
      t.string :provider
      t.text :description
      t.integer :ext_id
      t.datetime :post_date
      t.timestamps
    end
  end

  def self.down
    drop_table :external_items
  end
  
end
