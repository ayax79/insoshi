class FixExtIdColumn < ActiveRecord::Migration
  def self.up
    execute("alter table external_items alter column ext_id type bigint ")
  end

  def self.down
    execute("alter table external_items alter column ext_id type integer ")
  end
end
