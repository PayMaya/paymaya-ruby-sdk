require 'rest-client'
require 'plissken'

module Paymaya
  module Checkout
    class Webhook
      def register(name:, callback_url:)
        response = RestClient.post(webhook_url, {
          name: name,
          callbackUrl: callback_url
        }.to_json, auth_headers)
        JSON.parse(response).to_snake_keys
      end

      def retrieve
        response = RestClient.get(webhook_url, auth_headers)
        JSON.parse(response).map do |elem|
          elem.to_snake_keys
        end
      end

      def delete(id)
        response = RestClient.delete("#{webhook_url}/#{id}", auth_headers)
        JSON.parse(response).to_snake_keys
      end

      def webhook_url
        "#{Paymaya.config.base_url}/checkout/v1/webhooks"
      end

      def auth_headers
        {
          authorization:
            "Basic #{Base64.strict_encode64(Paymaya.config.secret_key + ':').chomp}",
          content_type: 'application/json'
        }
      end

      private :webhook_url
    end
  end
end
