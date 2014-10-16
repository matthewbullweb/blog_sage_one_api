require 'multi_json'

module SageOne
  # This helper methods in this module are used by the public api methods.
  # They use the Faraday::Connection defined in connection.rb for making
  # requests. Setting 'SageOne.raw_response' to true can help with debugging.
  # @api private
  module Request
    def delete(path, options={})
      request(:delete, path, options)
    end

    def get(path, options={})
      request(:get, path, options)
    end

    def post(path, options={})
      request(:post, path, options)
    end

    def put(path, options={})
      request(:put, path, options)
    end

    private

    def request(method, path, options)
      options = format_datelike_objects!(options) unless options.empty?
      response = connection.send(method) do |request|
        case method
        when :delete, :get
          options.merge!('$startIndex' => options.delete(:start_index)) if options[:start_index]
          request.url(path, options)
        when :post, :put
          request.path = path
          request.body = MultiJson.dump(options) unless options.empty?
        end
        request.headers['Host'] = request_host if request_host
      end

      if raw_response
        response
      elsif auto_traversal && ( next_url = links(response)["next"] )
        response.body + request(method, next_url, options)
      else
        response.body
      end
    end

    def links(response)
      links = ( response.headers["X-SData-Pagination-Links"] || "" ).split(', ').map do |link|
        url, type = link.match(/<(.*?)>; rel="(\w+)"/).captures
        [ type, url ]
      end

      Hash[ *links.flatten ]
    end

    def format_datelike_objects!(options)
      new_opts = {}
      options.map do |k,v|
        if v.respond_to?(:map)
          new_opts[k] = format_datelike_objects!(v)
        else
          new_opts[k] = v.respond_to?(:strftime) ? v.strftime("%d/%m/%Y") : v
        end
      end
      new_opts
    end

  end
end
