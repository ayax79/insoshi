class ArtistInvite < ActiveRecord::Base
  MAX_EMAIL = 40

  belongs_to :artist
  validates_presence_of :email
  validates_length_of :email, :within => 6..MAX_EMAIL

  before_validation :prepare_email
  after_create :send_invite_email 

  protected

  def prepare_email
    self.email = email.downcase.strip if email
  end

  def send_invite_email
    person = Person.find_by_email self.email
    if person                               
      ArtistMailer.deliver_artist_invite_notification self.artist, person
    else
      ArtistMailer.deliver_artist_invite_notification_non_member self.artist, self.email
    end
  end

end
