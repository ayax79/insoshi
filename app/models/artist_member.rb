class ArtistMember < ActiveRecord::Base
  include ActivityLogger
  extend PreferencesHelper

  belongs_to :artist
  belongs_to :person

  after_create :log_member_added

  protected

  def log_member_added
    add_activities(:item => self, :person => person, :artist => artist)
  end

end
