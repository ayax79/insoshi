require 'twitter'
require 'external_cred'
require 'external_item'

class TwitterAtivityDigester < Rooster::Task

  @tags = ['TwitterActivityDigester'] # CUSTOMIZE:  add additional tags here

  define_schedule do |s|
    s.every "1d", :first_at => Chronic.parse("next 2:00am"), :tags => @tags do  # CUSTOMIZE:  reference http://github.com/jmettraux/rufus-scheduler/tree/master
      begin
        log "#{self.name} starting at #{Time.now.to_s(:db)}"
        ActiveRecord::Base.connection.reconnect!
        execute_task
      ensure
        log "#{self.name} completed at #{Time.now.to_s(:db)}"
        ActiveRecord::Base.connection_pool.release_connection
      end
    end
  end

  def execute_task
    ExternalCred.find_all_twitter do |external_cred|
      unless external_cred.username.is_nil?
        person = external_cred.person
        item = ExternalItem.find_last_twitter_item person

        # if they have already imported activities in start with the last
        # id, otherwise start with today
        options = {}
        if item.nil?
          options[:since] = item.ext_id
        else
          options[:since_date] = Date.today
        end

        twitter_activity(external_cred.username, options) do |tweet|
          ExternalItem.create!(:provider => 'twitter',
                               :post_date => tweet.created_at,
                               :ext_id => tweet.id,
                               :description => tweet.text)
        end
      end
    end
  end

  def twitter_activity(username, options={})
    search = Twitter::Search.new.from username
    search.since options[:since] unless options[:since].nil?
    search.since_date options[:since_date] unless options[:since_date].nil?
    search.each { |x| yield x }
  end

end
