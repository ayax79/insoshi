class Artist < ActiveRecord::Base

  has_and_belongs_to_many :members, :class_name => 'Person', :join_table => 'artists_members'
  has_and_belongs_to_many :fans, :class_name => 'Person', :join_table => 'artists_fans'
  has_many :artist_invites, :dependent => :destroy

  validates_presence_of :name
  validates_uniqueness_of :name

end
