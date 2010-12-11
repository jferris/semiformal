require 'rubygems'
require 'bundler/setup'
require 'rake'
require 'date'
require 'rake/gempackagetask'
require 'cucumber/rake/task'
require 'rspec/core/rake_task'

desc 'Default: run the specs and cucumber features.'
task :default => [:spec, :cucumber]

Cucumber::Rake::Task.new(:cucumber) do |t|
  t.fork = true
  t.cucumber_opts = ['--format', (ENV['CUCUMBER_FORMAT'] || 'progress')]
end

RSpec::Core::RakeTask.new do |t|
  t.pattern = "spec/**/*_spec.rb"
  t.rspec_opts = "--format progress"
end

eval("$specification = begin; #{IO.read('semiformal.gemspec')}; end")
Rake::GemPackageTask.new($specification) do |package|
  package.need_zip = true
  package.need_tar = true
end
