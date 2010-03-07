class BaseMailer < ActionMailer::Base
  extend PreferencesHelper

  def domain
    @domain ||= BaseMailer.global_prefs.domain
  end

  def server
    @server_name ||= BaseMailer.global_prefs.server_name
  end

  private

  # Prepend the application name to subjects if present in preferences.
  def formatted_subject(text)
    name = PersonMailer.global_prefs.app_name
    label = name.blank? ? "" : "[#{name}] "
    "#{label}#{text}"
  end

  def preferences_note(person)
    %(To change your email notification preferences, visit http://#{server}/people/#{person.to_param}/edit#email_prefs)
  end

end