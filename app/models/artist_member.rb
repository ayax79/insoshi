class ArtistMember < ActiveRecord::Base
  extend ActivityLogger
  extend PreferencesHelper

  belongs_to :artist
  belongs_to :person

  after_create :log_member_added

  protected

  def log_member_added
# todo    add_activities :item => self, :person => self
  end

end
