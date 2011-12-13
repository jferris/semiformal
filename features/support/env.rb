require 'aruba/cucumber'
require 'nokogiri'

PROJECT_ROOT = File.expand_path(File.join(File.dirname(__FILE__), "..", ".."))

Before do
  @aruba_timeout_seconds = 140
end
