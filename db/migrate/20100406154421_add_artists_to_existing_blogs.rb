class AddArtistsToExistingBlogs < ActiveRecord::Migration
  def self.up
    Artist.find(:all).each do |artist|
      Blog.create!(:artist => artist) if artist.blog.nil?
    end
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration, "Can't unremove blogs"
  end
end
