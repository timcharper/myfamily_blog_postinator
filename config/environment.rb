APPROOT = File.dirname(__FILE__) + '/..'
LIBROOT = APPROOT + "/lib"
CONFIGROOT = APPROOT + "/config"
$: << LIBROOT
$: << APPROOT + '/vendor/gem'

require 'rubygems'
require 'bundler'
Bundler.setup
require 'activesupport'
require 'yaml'
require 'web-sickle/init.rb'
require 'mechanize'
require 'adapter'
require 'my_family'

CONFIG = YAML.load_file(CONFIGROOT + "/config.yml")


class Symbol
  def <=>(other)
    to_s <=> other.to_s
  end
end
