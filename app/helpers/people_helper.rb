module PeopleHelper

  def message_links(people)
    people.map { |p| email_link(p)}
  end

  # Link to a person (default is by name).
  def person_link(text, person = nil, html_options = nil)
    if person.nil?
      person = text
      text = person.name
    elsif person.is_a?(Hash)
      html_options = person
      person = text
      text = person.name
    end
    # We normally write link_to(..., person) for brevity, but that breaks
    # activities_helper_spec due to an RSpec bug.
    link_to(h(text), person, html_options)
  end

  # Same as person_link except sets up HTML needed for the image on hover effect
  def person_link_with_image(text, person = nil, html_options = nil)
    if person.nil?
      person = text
      text = person.name
    elsif person.is_a?(Hash)
      html_options = person
      person = text
      text = person.name
    end
    '<span class="imgHoverMarker">' + image_tag(person.thumbnail) + person_link(text, person, html_options) + '</span>'
  end

  def person_image_hover_text(text, person, html_options = nil)
    '<span class="imgHoverMarker">' + image_tag(person.thumbnail) + text + '</span>'
  end
  
  def activated_status(person)
    person.deactivated? ? "Activate" : "Deactivate"
  end
  
  private
    
    # Make captioned images.
    def captioned(images, captions)
      images.zip(captions).map do |image, caption|
        markaby do
          image << div { caption }
        end
      end
    end
end
