class FixDescriptionSize < ActiveRecord::Migration
  def self.up
     change_column :galleries, :description, :string, :limit => 1000 
  end

  def self.down
    change_column :galleries, :descrtipion, :string
  end
end
