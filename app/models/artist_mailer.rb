class ArtistMailer < BaseMailer

  def artist_invite_notification(artist, person)
    subject    "You have been marked as a member of #{artist.name}"
    recipients person.email
    from       "Message notification <message@#{domain}>"
    body       :artist => artist,
               :person => person,
               :artist_url => artist_url(artist)
  end


  def artist_invite_notification_non_member(artist, email)
    subject    "You have been marked as a member of #{artist.name}"
    recipients email
    from       "Message notification <message@#{domain}>"
    body       :artist => artist,
               :signup_url => signup_url
  end

end
