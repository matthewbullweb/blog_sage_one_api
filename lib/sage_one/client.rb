require 'sage_one/connection'
require 'sage_one/request'

require 'sage_one/oauth'

require 'sage_one/client/sales_invoices'
require 'sage_one/client/contacts'

module SageOne
  class Client
    attr_accessor(*Configuration::VALID_OPTIONS_KEYS)

    # Creates an instance of Client configured with
    # the current SageOne::Configuration options.
    # Pass in a hash of any valid options to override
    # them for this instance.
    #
    # @see SageOne::Configuration::VALID_OPTIONS_KEYS
    #   SageOne::Configuration::VALID_OPTIONS_KEYS
    def initialize(options={})
      options = SageOne.options.merge(options)
      Configuration::VALID_OPTIONS_KEYS.each do |key|
        send("#{key}=", options[key])
      end
    end

    include SageOne::Connection
    include SageOne::Request
    include SageOne::OAuth
    include SageOne::Client::SalesInvoices
    include SageOne::Client::Contacts
  end
end
