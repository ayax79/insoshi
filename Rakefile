# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require(File.join(File.dirname(__FILE__), 'config', 'boot'))

require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require 'tasks/rails'

namespace :ultrasphinx do

  task :postgres do
    sphinx_pg_dir = File.join File.dirname(__FILE__), 'vendor', 'plugins', 'ultrasphinx', 'lib', 'ultrasphinx', 'postgresql'
    databases = %w[insoshi_development insoshi_production insoshi_staging insoshi_test]
    scripts = %w[language.sql concat_ws.sql crc32.sql group_concat.sql hex_to_int.sql unix_timestamp.sql]
    databases.each do |db|
      scripts.each { |script| sh "psql #{db} < #{File.join(sphinx_pg_dir, script)}"}
    end
  end

end

namespace :db do

  task :dropall => :environment do
    ActiveRecord::Base.configurations.each_value do |config|
      sh 'dropdb ' + config['database']
    end
  end

end

namespace :mongrel do
	task :startall do 
		sh 'mongrel_rails start -d -p 3001 -P log/mongrel1.pid' 
		sh 'mongrel_rails start -d -p 3002 -P log/mongrel2.pid' 
		sh 'mongrel_rails start -d -p 3003 -P log/mongrel3.pid' 
	end
	task :stopall do 
		sh 'mongrel_rails stop -P log/mongrel1.pid' 
		sh 'mongrel_rails stop -P log/mongrel2.pid' 
		sh 'mongrel_rails stop -P log/mongrel3.pid' 
	end

end

task :initall do
  sh 'script/install'
  Rake::Task["db:test:prepare"].invoke
  Rake::Task["ultrasphinx:postgres"].invoke
  Rake::Task["ultrasphinx:configure"].invoke
  Rake::Task["ultrasphinx:index"].invoke
end

task :reinit do
  Rake::Task["db:dropall"].invoke
  Rake::Task[:initall].invoke
end


