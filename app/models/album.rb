class Album < ActiveRecord::Base

  UPLOAD_LIMIT = 5 # megabytes

  belongs_to :artist
  has_attachment :content_type => :image,
                 :storage => :file_system,
                 :max_size => UPLOAD_LIMIT.megabytes,
                 :min_size => 1,
                 :resize_to => '240>',
                 :thumbnails => { :thumbnail    => '72>',
                                  :icon         => '36>',
                                  :bounded_icon => '36x36>' },
                 :thumbnail_class => Thumbnail

  validates_presence_of :artist_id

end
