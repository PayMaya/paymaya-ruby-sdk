require 'rest-client'
require 'plissken'

module Paymaya
  module Checkout
    class Customization
      def set(logo_url:, icon_url:, apple_touch_icon_url:, custom_title:, color_scheme:)
        response = RestClient.post(customization_url, {
          logo_url: logo_url,
          icon_url: icon_url,
          apple_touch_icon_url: apple_touch_icon_url,
          custom_title: custom_title,
          color_scheme: color_scheme
        }.to_camelback_keys.to_json, auth_headers)
        JSON.parse(response)
      end

      def get
        response = RestClient.get(customization_url, auth_headers)
        JSON.parse(response)
      end

      def remove
        response = RestClient.delete(customization_url, auth_headers)
        JSON.parse(response)
      end

      def customization_url
        "#{Paymaya.config.base_url}/checkout/v1/customizations"
      end

      def auth_headers
        {
          authorization:
            "Basic #{Base64.strict_encode64(Paymaya.config.checkout_secret_key + ':').chomp}",
          content_type: 'application/json'
        }
      end

      private :customization_url, :auth_headers
    end
  end
end
