class Artist < ActiveRecord::Base
  include ActivityLogger
  extend PreferencesHelper

  MAX_DEFAULT_CONTACTS = 12
  FEED_SIZE = 10

  has_and_belongs_to_many :fans, :class_name => 'Person', :join_table => 'artists_fans'
  has_many :artist_invites, :dependent => :destroy
  has_many :activities, :through => :feeds, :order => 'activities.created_at DESC',
           :limit => FEED_SIZE,
           :conditions => ["people.deactivated = ?", false],
           :include => :person
  has_many :members, :class_name => 'ArtistMember'
  has_many :galleries
  has_many :photos, :dependent => :destroy, :order => 'created_at'

  validates_presence_of :name
  validates_uniqueness_of :name

  before_update :set_old_description
  after_update :log_activity_description_changed

  #photo helpers
  
  def photo
    # This should only have one entry, but use 'first' to be paranoid.
    photos.find_all_by_avatar(true).first
  end

  # Return all the photos other than the primary one
  def other_photos
    photos.length > 1 ? photos - [photo] : []
  end

  def main_photo
    photo.nil? ? "default.png" : photo.public_filename
  end

  def thumbnail
    photo.nil? ? "default_thumbnail.png" : photo.public_filename(:thumbnail)
  end

  def icon
    photo.nil? ? "default_icon.png" : photo.public_filename(:icon)
  end

  def bounded_icon
    photo.nil? ? "default_icon.png" : photo.public_filename(:bounded_icon)
  end

  # Return the photos ordered by primary first, then by created_at.
  # They are already ordered by created_at as per the has_many association.
  def sorted_photos
    # The call to partition ensures that the primary photo comes first.
    # photos.partition(&:primary) => [[primary], [other one, another one]]
    # flatten yields [primary, other one, another one]
    @sorted_photos ||= photos.partition(&:primary).flatten
  end


  def recent_activity
    Activity.find_all_by_artist_id(self, :order => 'created_at DESC',
                                   :limit => FEED_SIZE)
  end

  def member?(person)
    !ArtistMember.find(:first,
                       :conditions => [" person_id = ? and artist_id = ?", person.id, self.id ]).nil?
  end

  def fan?(person)
    fans.include? person
  end

  protected

  def set_old_description
    @old_description = Artist.find(self).description
  end

  def log_activity_description_changed
    unless @old_description == description or description.blank?
      add_activities(:item => self, :artist => self)
    end
  end

end
