class Album < ActiveRecord::Base

  UPLOAD_LIMIT = 5 # megabytes

  attr_protected :id, :artist_id, :parent_id, :created_at, :updated_at

  belongs_to :artist
  has_many :songs 

  has_attachment :content_type => :image,
                 :storage => :file_system,
                 :max_size => UPLOAD_LIMIT.megabytes,
                 :min_size => 1,
                 :resize_to => '240>',
                 :thumbnails => { :thumbnail    => '72>',
                                  :icon         => '36>',
                                  :bounded_icon => '36x36>' },
                 :thumbnail_class => AlbumThumbnail

  acts_as_list :scope => :artist_id

  validates_presence_of :artist_id, :title

  # Override the crappy default AttachmentFu error messages.
  def validate
    if filename.nil?
      errors.add_to_base("You must choose a file to upload")
    else
      # Images should only be GIF, JPEG, or PNG
      enum = attachment_options[:content_type]
      unless enum.nil? || enum.include?(send(:content_type))
        errors.add_to_base("You can only upload images (GIF, JPEG, or PNG)")
      end
      # Images should be less than UPLOAD_LIMIT MB.
      enum = attachment_options[:size]
      unless enum.nil? || enum.include?(send(:size))
        msg = "Images should be smaller than #{UPLOAD_LIMIT} MB"
        errors.add_to_base(msg)
      end
    end
  end

end
