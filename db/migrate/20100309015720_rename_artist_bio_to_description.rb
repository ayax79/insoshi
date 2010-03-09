# Renaming the column so that it will be more consistent with the user object
class RenameArtistBioToDescription < ActiveRecord::Migration
  def self.up
    rename_column :artists, :bio, :description
  end

  def self.down
    rename_column :artists, :description, :bio
  end
end
