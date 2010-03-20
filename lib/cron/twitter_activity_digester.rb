require 'rubygems'
require 'twitter'
require 'external_cred'
require 'external_item'
require 'logger'

class TwitterActivityDigester < Logger::Application

  def initialize
    super('TwitterActivityDigester')
  end


  def run
    log(INFO, 'Starting TwitterActivityDigester')
    external_creds = ExternalCred.find_all_twitter
    log(WARN, 'No external credentials found!') if external_creds.empty?
    external_creds.each do |external_cred|
      unless external_cred.username.nil?
        log(INFO, "handling twitter username #{external_cred.username}")
        person = external_cred.person
        item = ExternalItem.find_last_twitter_item person

        # if they have already imported activities in start with the last
        # id, otherwise start with today
        options = {}
        if !item.nil?
          options[:since] = item.ext_id
        else
          options[:since_date] = Date.yesterday
        end

        twitter_activity(external_cred.username, options) do |tweet|
          log(DEBUG, "Adding tweet - #{tweet.to_yaml}")
          ExternalItem.create!(:provider => 'twitter',
                               :post_date => tweet.created_at,
                               :ext_id => tweet.id,
                               :description => tweet.text,
                               :person => external_cred.person)
        end
      end
    end                                         
  end

  def twitter_activity(username, options={})
    log(INFO, 'fetching twitter activity: options' +options.to_yaml)
    search = Twitter::Search.new.from username
    search.since options[:since] unless options[:since].nil?
    search.since_date options[:since_date] unless options[:since_date].nil?
    puts search.to_yaml
    search.each do |x|
      log(INFO, "in search with #{x.to_yaml}")
      yield x
    end
  end

end

if $0 =~ /runner/
  TwitterActivityDigester.new.run
end
