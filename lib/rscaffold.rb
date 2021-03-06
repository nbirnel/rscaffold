require 'erb'
require 'rscaffold/version'
require 'fileutils'
include FileUtils

module RScaffold

  def self.camel_case string
    string.split(/_/).map{|w| w.capitalize}.join ''
  end

  class Project
    ATTRS = %w(
      bin
      camel
      codeclimate
      description
      email
      fullname
      gemversion
      homepage
      license
      location
      owner
      remote
      remote_path
      req_rubyver
      summary
      travis
      usage
      whoami
    )
    
    ATTRS.each{|a| attr_accessor a.to_sym}

    attr_reader :name

    def initialize name
      @name  = name
      @bin   = @name
      @camel = RScaffold.camel_case @name

      @cur_rubyver = '2.1'
      @erb_required_ruby_version = '<%=@spec.required_ruby_version.to_s%>'
      @req_rubyver = '>=1.8.7'
      @license = 'MIT'

      @today = Time.now.strftime '%Y-%m-%d'
      @year  = Time.now.year

      # This disgusting thing is to work across *nix, Windows, and Cygwin.
      @whoami   = ( ENV["USER"] || ENV["USERNAME"] ).sub(/.*\\/, '')
      @email    = `git config --get user.email`
      @fullname = `git config --get user.name`
      @owner    = @fullname

      @remote_path = "#{@whoami}/#{@name}"
      @remote      = "http://github.com/#{@remote_path}"
      @homepage    = @remote
      @travis      = travis_of      @remote_path
      @codeclimate = codeclimate_of @remote_path
      @gemversion  = gemversion_of  @name

      @summary     = "#FIXME summary"
      @description = "#FIXME description"
      @usage       = "#FIXME usage"
      @website     = "#FIXME website"

      @location = {
        :bin       => "bin/#{@bin}",
        :gemfile   => "Gemfile",
        :gemspec   => "#{@name}.gemspec",
        :gitignore => ".gitignore",
        :license   => "LICENSE",
        :man       => "man/man1/#{@bin}.1",
        :project   => "lib/#{@name}.rb",
        :rakefile  => "Rakefile",
        :readme    => "doc-src/README.md.erb",
        :rspec     => ".rspec",
        :spec      => "spec/#{@name}_spec.rb",
        :travis    => ".travis.yml",
        :version   => "lib/#{@name}/version.rb",
      }

    end

    def rendered template
      ERB.new(contents(template), nil).result binding
    end

    def write template
      FileUtils.mkdir_p File.dirname @location[template.to_sym]
      File.open(@location[template.to_sym], 'w') do |file|
        file.write rendered template
      end
    end

    def git_init
      `git init`
      `git add .`
      `git commit -m'initial commit' -a`
    end

    def rvm_create
      `rvm --create use #{cur_rubyver}@#{@name} --ruby-version`
      `bundle install`
    end

    def write_all
      @location.keys.each{|template| self.write(template.to_s)}
    end
    
    def licenses_avail
      l = Dir.entries(licenses).reject{|el| el =~ /^(\.|\.\.)$/}
      l.map{|fn| fn.sub(/\.erb$/, '')}
    end

    private

    def travis_of path
      travis_dir = "https://travis-ci.org/#{path}"
      "[![Build Status](#{travis_dir}.png?branch=master)](#{travis_dir})"
    end

    def codeclimate_of path
      codeclimate_dir = "https://codeclimate.com/github/#{path}"
      "[![Code Climate](#{codeclimate_dir}.png)](#{codeclimate_dir})"
    end

    def gemversion_of path
      gemversion_dir = "https://badge.fury.io/rb/#{path}"
      "[![Gem Version](#{gemversion_dir}.png)](#{gemversion_dir})"
    end

    def contents template
      if template == 'license'
        filename = @license
        dir = licenses
      else
        filename = template
        dir = templates
      end
      file     = "#{filename}.erb"
      File.read(File.join(dir, file))
    end

    def templates
      File.join(File.dirname(__FILE__), 'templates')
    end

    def licenses
      File.join(File.dirname(__FILE__), 'licenses')
    end

  end

end
