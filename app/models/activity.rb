# == Schema Information
# Schema version: 20080916002106
#
# Table name: activities
#
#  id         :integer(4)      not null, primary key
#  public     :boolean(1)      
#  item_id    :integer(4)      
#  person_id  :integer(4)      
#  item_type  :string(255)     
#  created_at :datetime        
#  updated_at :datetime        
#

class Activity < ActiveRecord::Base
  belongs_to :person
  belongs_to :artist
  belongs_to :item, :polymorphic => true
  has_many :feeds, :dependent => :destroy
  
  GLOBAL_FEED_SIZE = 10

  def self.global_feed
    find(:all,
         :order => 'activities.created_at DESC',
         :limit => GLOBAL_FEED_SIZE)
  end
end
