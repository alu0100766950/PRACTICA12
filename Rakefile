$:.unshift File.dirname(__FILE__) + 'lib'
    require "bundler/gem_tasks"

    require 'rspec/core/rake_task'
    RSpec::Core::RakeTask.new
    task :default => :spec

#task :spec do
#sh "rspec -I. spec/pract12_spec.rb"
#end

#task :doc do
#sh "rspec -I. spec/pract12_spec.rb --format documentation"
#end

#desc"Salida con formato html"
#task :html do
#sh "rspec -I. spec/pract12_spec.rb --format html --out report.html"
#end
