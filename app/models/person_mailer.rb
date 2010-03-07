class PersonMailer < BaseMailer
  
  def password_reminder(person)
    from         "Password reminder <password-reminder@#{domain}>"
    recipients   person.email
    subject      formatted_subject("Password reminder")
    body         "person" => person
  end
  
  def message_notification(message)
    from         "Message notification <message@#{domain}>"
    recipients   message.recipient.email
    subject      formatted_subject("New message")
    body         "server" => server, "message" => message,
                 "preferences_note" => preferences_note(message.recipient)
  end
  
  def connection_request(connection)
    from         "Contact request <connection@#{domain}>"
    recipients   connection.person.email
    subject      formatted_subject("Contact request from #{connection.contact.name}")
    body         "server" => server,
                 "connection" => connection,
                 "url" => edit_connection_path(connection),
                 "preferences_note" => preferences_note(connection.person)
  end
  
  def blog_comment_notification(comment)
    from         "Comment notification <comment@#{domain}>"
    recipients   comment.commented_person.email
    subject      formatted_subject("New blog comment")
    body         "server" => server, "comment" => comment,
                 "url" => 
                 blog_post_path(comment.commentable.blog, comment.commentable),
                 "preferences_note" => 
                    preferences_note(comment.commented_person)
  end
  
  def wall_comment_notification(comment)
    from         "Comment notification <comment@#{domain}>"
    recipients   comment.commented_person.email
    subject      formatted_subject("New wall comment")
    body         "server" => server, "comment" => comment,
                 "url" => person_path(comment.commentable, :anchor => "wall"),
                 "preferences_note" => 
                    preferences_note(comment.commented_person)
  end
  
  def email_verification(ev)
    from         "Email verification <email@#{domain}>"
    recipients   ev.person.email
    subject      formatted_subject("Email verification")
    body         "server_name" => server,
                 "code" => ev.code
  end
  
end
