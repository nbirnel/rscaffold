include FileUtils
require 'rscaffold/version'

#copy everything over, 
#  substituting as we go.

#git init
#

project = ARGV[0]
rubyver= '>=1.8.7'
whoami = ( ENV["USER"] || ENV["USERNAME"] ).sub(/.*\\/, '')
bin = project
remote_path = "#{whoami}/#{bin}"
remote = "http://github.com/#{remote_path}"
license     = 'MIT'
project_camel = camel_case project
today = Time.now.strftime '%Y-%m-%d'
yyyy = Time.now.year

email    = `git config -get user.email`
fullname = `git config -get user.name`
homepage   = remote

summary     = "!!SUMMARY!!"
description = "!!DESCRIPTION!!"
usage =  "!!USAGE!!"

def travis path
  travis_dir = "https://travis-ci.org/#{path}"
  "[![Build Status](#{travis_dir}.png?branch=master)](#{travis_dir})"
end

travis remote_path

def codeclimate path
  codeclimate_dir = "https://codeclimate.com/github/#{path}"
  "[![Code Climate](#{codeclimate_dir}.png)](#{codeclimate_dir})"
end

codeclimate remote_path

def gemversion path path
  gemversion_dir = "https://badge.fury.io/rb/#{path}"
  "[![Gem Version](#{gemversion_dir}.png)](#{gemversion_dir})"
end

gemversion project



