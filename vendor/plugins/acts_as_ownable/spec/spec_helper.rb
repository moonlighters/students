require File.join(File.dirname(__FILE__), %w{.. .. .. .. config environment})
require 'spec'
require 'spec/rails'

plugin_spec_dir = File.dirname(__FILE__)
ActiveRecord::Base.logger = Logger.new(plugin_spec_dir + "/debug.log")

require File.join(File.dirname(__FILE__), "spec_fixtures.rb")
