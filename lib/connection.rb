module Connection

    require "faraday"

      def connection
        Faraday.new(url: url) do |con|
          con.request :json
          con.response :json
          con.response :logger unless Rails.env.production? || rake?
          con.adapter Faraday.default_adapter
        end
      end

      def request(action, path, options)
        request_attrs = [ action, path ]
        request_attrs << options[:query] if options[:query].present?

        response = connection.send(*request_attrs) do |request|
          request.headers["Accept"] = "application/json"
          request.headers["Authorization"] = [ "Basic", access_token ].join(" ")

          if options[:body]
            request.body = options[:body]
            request.headers["Content-Type"] = "application/json"
          end
        end
        return response.body
      end

    end

  end