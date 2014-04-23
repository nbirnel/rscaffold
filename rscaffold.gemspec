require  "#{File.dirname(__FILE__)}/lib/rscaffold/version"

@spec = Gem::Specification.new do |s|
  s.name        = 'rscaffold'
  s.version     = RScaffold::VERSION
  s.date        = '2014-04-23'
  s.required_ruby_version = '>=1.9.2'
  s.summary     = "make a new ruby project"
  s.description = "rscaffold is a similar concept to jeweler, 
    but is meant to be simpler and smaller."
  s.authors     = ['Noah Birnel']
  s.email       = 'nbirnel@gmail.com'
  s.homepage    = 'http://github.com/nbirnel/rscaffold'
  s.files       = Dir.glob("{bin,lib}/**/*") + [
    'README.md',
    'rscaffold.gemspec',
    'spec/rscaffold_spec.rb'
  ]
  s.has_rdoc    = true
  s.executables = ['rscaffold']
  s.license     = 'MIT'
end
