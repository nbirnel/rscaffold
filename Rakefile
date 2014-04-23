require 'erb'
require 'rspec/core/rake_task'
require 'rake/clean'
load 'rscaffold.gemspec'

RSpec::Core::RakeTask.new('spec')

VER  = RScaffold::VERSION
PROG = 'rscaffold'
NAME = 'rscaffold'

BIN  = FileList['bin/*.rb']
GEM  = "#{PROG}-#{VER}.gem"
LIB  = FileList['lib/*.rb', 'lib/*/*.rb']
MAN  = FileList['man/man*/*.?']
MANDIR = '/usr/local/man/man1/'
MANFILE = "#{NAME}.1"
MANDEST = [MANDIR, MANFILE].join '/'
README = FileList['README.md']
READMESRC = 'doc-src/README.md.erb'
SPEC = "#{PROG}.gemspec"
TEST = FileList['spec/*.rb']
CLEAN.include('doc', '*.gem')

task :all => [:spec, :install]

task :default => :spec

task :test => :spec

task :spec 

file 'doc' => LIB  do
  `rdoc lib/`        #FIXME shell out not cool
end

task :readme => README
  `git commit -m'update README' README.md`

file README =>[READMESRC, MAN].flatten do
  erbify READMESRC, README
  `groff -tman -Thtml #{MAN} | sed '/<html/,$!d; /<style/,/<\\/style>/d' >>#{README}`
end

task :gem => GEM

file GEM => [LIB, BIN, TEST, SPEC, README].flatten do
  `gem build #{SPEC}`            #FIXME shell out not cool
end

task :install => [:install_gem]

task :install_gem => GEM do
  `gem install #{GEM}`            #FIXME shell out not cool
end

task :push do
  `git push origin master`            #FIXME shell out not cool
end

task :publish => :gem do
  `gem push #{GEM}`            #FIXME shell out not cool
end

task :uninstall do
  `gem uninstall #{PROG}`     #FIXME shell out not cool
end

def rendered template
  ERB.new(File.read(template), nil).result binding
end

def erbify template, destination
  File.open(destination.to_s, 'w') do |file|
    file.write rendered template
  end
end
