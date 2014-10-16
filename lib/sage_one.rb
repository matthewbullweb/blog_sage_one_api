$:.unshift File.dirname(__FILE__)

require 'sage_one/configuration'
require 'sage_one/client'
require 'sage_one/error'


module SageOne
  extend Configuration
  class << self
    # Alias for SageOne::Client.new
    #
    # @return [SageOne::Client]
    def new(options={})
      SageOne::Client.new(options)
    end

    # True if the method can be delegated to the SageOne::Client
    #
    # @return [Boolean]
    def respond_to?(method, include_private=false)
      new.respond_to?(method, include_private) || super(method, include_private)
    end

    # Delegate to SageOne::Client.new
    def method_missing(method, *args, &block)
      return super unless new.respond_to?(method)
      new.send(method, *args, &block)
    end
  end
end
