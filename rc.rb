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

put '/db_migrate' do
  `rake db:migrate`
end

def check_auth(token)
  halt 403, "No token specified" unless token
  YAML::load_documents(File.open(File.join(File.dirname(__FILE__), 'config', 'rc.yml'))) do |doc|
    return if (doc['user']['token'] == token)
  end
  halt 403, "Unknown token"
end
