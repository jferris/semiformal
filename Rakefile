require "bundler/gem_tasks"
require 'rspec/core/rake_task'
require 'cucumber/rake/task'
require 'reek/rake/task'

desc 'Default: run all tests and metrics'
task :default => [:spec, :cucumber, :reek]

Cucumber::Rake::Task.new(:cucumber) do |t|
  t.fork = true
  t.cucumber_opts = ['--format', (ENV['CUCUMBER_FORMAT'] || 'progress')]
end

RSpec::Core::RakeTask.new do |t|
  t.pattern = "spec/**/*_spec.rb"
  t.rspec_opts = "--format progress"
end

Reek::Rake::Task.new do |t|
  t.fail_on_error = true
  t.reek_opts = '-q'
end
