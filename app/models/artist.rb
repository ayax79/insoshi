class Artist < ActiveRecord::Base

  MAX_DEFAULT_CONTACTS = 12

  has_and_belongs_to_many :members, :class_name => 'Person', :join_table => 'artists_members'
  has_and_belongs_to_many :fans, :class_name => 'Person', :join_table => 'artists_fans'
  has_many :artist_invites, :dependent => :destroy

  validates_presence_of :name
  validates_uniqueness_of :name

  #photo helpers

  def thumbnail
    #todo - implement
    "default_thumbnail.png"
  end

   def other_photos
    photos.length > 1 ? photos - [photo] : []
  end

  def main_photo
    #todo - implement
    "default.png"
  end

end
