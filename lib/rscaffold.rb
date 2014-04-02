require 'erb'
require 'rscaffold/version'
include FileUtils

module RScaffold

  def self.camel_case string
    string.split(/_/).map{|w| w.capitalize}.join ''
  end

  class Project
    %w(
      bin
      camel
      rubyver
      license
      whoami
      email
      fullname
      remote_path
      remote
      homepage
      travis
      codeclimate
      gemversion
      summary
      description
      usage
      location
    ).each{|a| attr_accessor a.to_sym}

    attr_reader :name

    def initialize name
      @name  = name
      @bin   = @name
      @camel = RScaffold.camel_case @name

      @rubyver = '>=1.8.7'
      @license = 'MIT'

      @today = Time.now.strftime '%Y-%m-%d'
      @yyyy  = Time.now.year

      @whoami   = ( ENV["USER"] || ENV["USERNAME"] ).sub(/.*\\/, '')
      @email    = `git config --get user.email`
      @fullname = `git config --get user.name`

      @remote_path = "#{@whoami}/#{@name}"
      @remote      = "http://github.com/#{@remote_path}"
      @homepage    = @remote
      @travis      = travis_of      @remote_path
      @codeclimate = codeclimate_of @remote_path
      @gemversion  = gemversion_of  @name

      @summary     = "!!SUMMARY!!"
      @description = "!!DESCRIPTION!!"
      @usage       = "!!USAGE!!"

      @location = {
        :gemspec   => "#{@name}.gemspec",
        :gemfile   => "Gemfile",
        :bin       => "bin/#{@bin}",
        :readme    => "doc-src/README.md",
        :gitignore => ".gitignore",
        :project   => "lib/#{@name}.rb",
        :version   => "lib/#{@name}/version.rb",
        :license   => "LICENSE",
        :man       => "man/man1/#{@bin}.1",
        :rakefile  => "Rakefile",
        :rspec     => ".rspec",
        :spec      => "spec/#{@name}_spec.rb",
        :travis    => ".travis.yml",
      }

    end

    def render template
      filename = "#{template}.erb"
      template_contents = File.read(File.join(templates, filename))
      ERB.new(template_contents, nil, '<>').result binding
    end

    def write template
      contents = render template
      FileUtils.mkdir_p File.dirname @location[template.to_sym]
      File.open(@location[template.to_sym], 'w') do |file|
        file.write contents
      end
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

    def templates
      File.join(File.dirname(__FILE__), 'templates')
    end

  end

end
