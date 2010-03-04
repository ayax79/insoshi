#!/usr/bin/env ruby

# Script performing remote control build commands

require 'rubygems'
require 'sinatra'
require 'yaml'

set :port, 23432

before do
  check_auth(params[:token])
end

put '/server_restart' do
  output = `rake mongrel:stopall`
  output + `rake mongrel:startall`
  return output
end

put '/server_stop' do
  `rake mongrel:stopall`
end

put '/server_start' do
  `rake mongrel:startall`
end

put '/db_migrate' do
  `rake db:migrate`
end

def check_auth(token)
  throw :halt,  [403, "No token specified"] unless token
  found = false
  YAML::load_documents(File.open(File.join(File.dirname(__FILE__), 'config', 'rc.yml'))) do |doc|
    doc.each_value do |val|
      current_token = val['token']
      found = true if (current_token == token)
    end
  end
  throw :halt, [403, "Unknown token"] unless found
end
