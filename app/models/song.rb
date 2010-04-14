class Song < ActiveRecord::Base

  UPLOAD_LIMIT = 20

  belongs_to :album

  # TODO - limit by :content_type
  has_attachment :storage => :file_system,
                 :max_size => UPLOAD_LIMIT.megabytes,
                 :min_size => 1

  acts_as_list :scope => :album_id

  validates_presence_of :album_id, :title

  # Override the crappy default AttachmentFu error messages.
  def validate
    if filename.nil?
      errors.add_to_base("You must choose a file to upload")
    else
      # Images should be less than UPLOAD_LIMIT MB.
      enum = attachment_options[:size]
      unless enum.nil? || enum.include?(send(:size))
        msg = "Images should be smaller than #{UPLOAD_LIMIT} MB"
        errors.add_to_base(msg)
      end
    end
  end
end
