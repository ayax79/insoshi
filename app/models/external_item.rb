class ExternalItem < ActiveRecord::Base
  include ActivityLogger

  belongs_to :person
  validates_presence_of :provider, :description, :person, :post_date
  validates_presence_of :ext_id, :if => :twitter?

  class << self

    def find_last_twitter_item(person)
      ExternalItem.first(:conditions => [ 'person_id = ? and provider = ?', person, 'twitter'],
                         :order => ' ext_id DESC ' )
    end

  end

  def twitter?
    provider == 'twitter'
  end

  def facebook?
    provider == 'facebook'
  end


end
