APPROOT = File.dirname(__FILE__) + '/..'
LIBROOT = APPROOT + "/lib"
CONFIGROOT = APPROOT + "/config"
$: << LIBROOT

require 'rubygems'
require 'activesupport'
require 'yaml'
require 'mechanize'
require 'adapter'

CONFIG = YAML.load_file(CONFIGROOT + "/config.yml")


class Symbol
  def <=>(other)
    to_s <=> other.to_s
  end
end