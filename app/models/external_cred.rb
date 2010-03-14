class ExternalCred < ActiveRecord::Base
  
  belongs_to :person
  validates_presence_of :provider, :identifier, :person

  def ExternalCred.determine_provider_from_rpx(provider)
    case (provider)
      when 'Facebook' then 'facebook'
      when 'Google' then 'google'
      when 'Twitter' then 'twitter'
      when 'MySpace' then 'my_space'
      when 'Other' then 'other'
      else 'unknown'
    end
  end

end
