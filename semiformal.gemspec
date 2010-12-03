Gem::Specification.new do |s|
  s.name        = %q{semiformal}
  s.version     = '0.1'
  s.summary     = %q{blah blah blah}
  s.description = %q{BLAH BLAH BLAH}

  s.files        = Dir['[A-Z]*',
                       'lib/**/*.rb',
                       'features/**/*',
                       'bin/**/*',
                       'spec/**/*.rb']
  s.require_path = 'lib'
  s.test_files   = Dir['features/**/*']

  s.has_rdoc = false

  s.authors = ["Joe Ferris"]
  s.email   = %q{jferris@thoughtbot.com}
  s.homepage = "http://github.com/jferris/semiformal"

  s.platform = Gem::Platform::RUBY
  s.rubygems_version = %q{1.2.0}
end

