require 'rubygems'
require 'bundler/setup'
require 'rake'
require 'date'
require 'rake/gempackagetask'
require 'cucumber/rake/task'
require 'rspec/core/rake_task'
require 'reek/rake/task'

desc 'Default: run all tests and metrics'
task :default => [:spec, :cucumber, :rcov, :reek]

Cucumber::Rake::Task.new(:cucumber) do |t|
  t.fork = true
  t.cucumber_opts = ['--format', (ENV['CUCUMBER_FORMAT'] || 'progress')]
end

RSpec::Core::RakeTask.new do |t|
  t.pattern = "spec/**/*_spec.rb"
  t.rspec_opts = "--format progress"
end

desc "Run rcov"
RSpec::Core::RakeTask.new(:rcov) do |t|
  t.rcov = true
  t.rcov_opts = %{--exclude osx\/objc,spec,gems\/ --failure-threshold 100}
  t.pattern = "spec/**/*_spec.rb"
  t.rspec_opts = "--format progress"
end

Reek::Rake::Task.new do |t|
  t.fail_on_error = true
  t.reek_opts = '-q'
end

eval("$specification = begin; #{IO.read('semiformal.gemspec')}; end")
Rake::GemPackageTask.new($specification) do |package|
  package.need_zip = true
  package.need_tar = true
end
