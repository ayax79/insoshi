class RemoteActivityDigesterTask < Rooster::Task

  @tags = ['RemoteActivityDigester'] # CUSTOMIZE:  add additional tags here

  define_schedule do |s|
    s.every "1d", :first_at => Chronic.parse("next 2:00am"), :tags => @tags do  # CUSTOMIZE:  reference http://github.com/jmettraux/rufus-scheduler/tree/master
      begin
        log "#{self.name} starting at #{Time.now.to_s(:db)}"
        ActiveRecord::Base.connection.reconnect!

        rpx = build_rpx
        rpx.mappings.each do |mapping|
          



        end


      ensure
        log "#{self.name} completed at #{Time.now.to_s(:db)}"
        ActiveRecord::Base.connection_pool.release_connection
      end
    end
  end

  def build_rpx
    Rpx::RpxHelper.new(RPX_API_KEY, RPX_BASE_URL, RPX_REALM)
  end


end