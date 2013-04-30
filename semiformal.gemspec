# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "semiformal/version"

Gem::Specification.new do |s|
  s.name        = %q{semiformal}
  s.version     = Semiformal::VERSION.dup
  s.authors     = ["Joe Ferris"]
  s.email       = %q{jferris@thoughtbot.com}
  s.homepage    = "http://github.com/jferris/semiformal"
  s.summary     = %q{blah blah blah}
  s.description = %q{BLAH BLAH BLAH}

  s.rubyforge_project = "semiformal"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "cucumber"
  s.add_development_dependency "aruba"
  s.add_development_dependency "rake"
  s.add_development_dependency "rspec"
  s.add_development_dependency "rails", "~> 3.2.0"
  s.add_development_dependency "nokogiri"
  s.add_development_dependency "capybara"
  s.add_development_dependency "launchy"
  s.add_development_dependency "rack"
  s.add_development_dependency "reek"
end

