require 'erb'
require 'rspec/core/rake_task'
require 'rake/clean'
require 'tempfile'
load 'rscaffold.gemspec'
VERSIONFILE = 'lib/rscaffold/version.rb'

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
CLEAN.include('doc', '*.gem', 'README.md')

task :all => [:spec, :install]

task :default => :spec

task :test => :spec

task :spec 

file 'doc' => LIB  do
  `rdoc`        #FIXME shell out not cool
end

task :readme => README
  `git add README.md`
  `git commit -m'update README' README.md`

file README =>[READMESRC, MAN].flatten do
  erbify READMESRC, README
  `groff -tman -Thtml #{MAN} | sed '/<html/,$!d; /<style/,/<\\/style>/d' >>#{README}`
end

task :gem => GEM

file GEM => [LIB, BIN, TEST, MAN, SPEC, README].flatten do
  `gem build #{SPEC}`            #FIXME shell out not cool
end

task :install => :install_gem

task :install_all => [:install_gem, :install_man]

task :install_gem => GEM do
  `gem install #{GEM}`            #FIXME shell out not cool
end

task :install_man => MAN do
  mkdir_p MANDIR
  cp MAN, MANDIR
end

['major', 'minor', 'patch'].each do |v|
  task "bump_#{v}".to_sym do
    bump v
  end
end

task :push do
  `git push origin master`            #FIXME shell out not cool
end

task :publish => :gem do
  `gem push #{GEM}`            #FIXME shell out not cool
end

task :uninstall do
  `gem uninstall #{PROG}`     #FIXME shell out not cool
  File.delete MANDEST
end

def rendered template
  ERB.new(File.read(template), nil).result binding
end

def erbify template, destination
  File.open(destination.to_s, 'w') do |file|
    file.write rendered template
  end
end

def update file
  t_file = Tempfile.new("rake_update")
  File.open(file, 'r') do |f|
    f.each_line{|l| t_file.puts yield(l) }
  end
  t_file.close
  FileUtils.mv(t_file.path, file)
  FileUtils.chmod 0644, file
end

def bump part
  part = part.upcase
  zero = ['PATCH', 'MINOR', 'MAJOR'].take_while{|v| v != part}
  zero = "(#{zero.join('|')})"

  re = {}
  [part, zero].each{|e| re[e] = /(?<part>^\s*#{e} = )(?<num>[0-9]+)/}
  
  update VERSIONFILE do |l|
    l =~ re[part] && l = "#{$~[:part]}#{$~[:num].to_i + 1}"
    l =~ re[zero] && l = "#{$~[:part]}0"
    l
  end
  `git commit -m'bump #{part.downcase}' #{VERSIONFILE}`
end
