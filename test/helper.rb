require 'rubygems'
require 'test/unit'
require 'active_support'
require 'active_support/test_case'
require 'yaml'

dir = File.dirname(File.expand_path(__FILE__))
$LOAD_PATH.unshift(File.join(dir, "..", "lib"))
$LOAD_PATH.unshift(dir)

gem 'ruby-net-ldap'


CONFIG = YAML.load(File.open(File.join(dir,"config.yml")))

require 'active_directory'

ActiveDirectory::Base.setup(CONFIG[:connection])
