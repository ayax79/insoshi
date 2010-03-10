class AllowActivitiesToBeUsedByArtists < ActiveRecord::Migration
  def self.up
    add_column :activities, :artist_id, :integer
    add_column :feeds, :artist_id, :integer
  end

  def self.down
    execute "alter table activities drop column artist_id"
    execute "alter table feed drop column artist_id"
  end
end
