require File.join(File.dirname(__FILE__), 'lib', 'acts_as_ownable.rb')
ActiveRecord::Base.send :include, ActiveRecord::Acts::Ownable
