require './lib/!!PROJECT!!'

Gem::Specification.new do |s|
  s.name        = '!!PROJECT!!'
  s.version     = !!PROJECTCAMEL!!::VERSION
  s.date        = '!!TODAY!!'
  s.required_ruby_version = '!!RUBYVER!!'
  s.summary     = "!!SUMMARY!!"
  s.description = "!!DESCRIPTION!!"
  s.authors     = ['!!WHOAMI!!']
  s.email       = '!!EMAIL!!'
  s.homepage    = '!!HOMEPAGE!!'
  s.files       = ['README.md', '!!PROJECT!!.gemspec', 'lib/!!PROJECT!!.rb', 'spec/!!PROJECT!!_spec.rb', 'bin/!!PROJECT!!']
  s.has_rdoc    = true
  s.executables = ['!!PROJECT!!']
  s.license     = '!!LICENCE!!'
end
