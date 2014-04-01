require  "#{File.dirname(__FILE__)}/lib/rscaffold/version"

Gem::Specification.new do |s|
  s.name        = 'rscaffold'
  s.version     = RScaffold::VERSION
  s.date        = '2014-03-28'
  s.required_ruby_version = '>=1.8.7'
  s.summary     = "make a new gem"
  s.description = "foo"
  s.authors     = ['Noah Birnel']
  s.email       = 'nbirnel@gmail.com'
  s.homepage    = 'http://github.com/nbirnel/rscaffold'
  s.files       = [
    'README.md',
    'rscaffold.gemspec',
    'lib/rscaffold.rb',
    'lib/rscaffold/version.rb',
    'spec/rscaffold_spec.rb'
  ]
  s.has_rdoc    = true
  s.license     = 'MIT'
end
