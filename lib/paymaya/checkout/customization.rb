# frozen_string_literal: true
require 'rest-client'

require 'paymaya/helper'

module Paymaya
  module Checkout
    class Customization
      def set(logo_url:, icon_url:, apple_touch_icon_url:, custom_title:,
        color_scheme:)
        Helper.request(:post, customization_url, {
          logo_url: logo_url,
          icon_url: icon_url,
          apple_touch_icon_url: apple_touch_icon_url,
          custom_title: custom_title,
          color_scheme: color_scheme
        }, Helper.checkout_secret_auth_headers)
      end

      def get
        Helper.request(:get, customization_url, {},
          Helper.checkout_secret_auth_headers)
      end

      def remove
        Helper.request(:delete, customization_url, {},
          Helper.checkout_secret_auth_headers)
      end

      def customization_url
        "#{Paymaya.config.base_url}/checkout/v1/customizations"
      end

      private :customization_url
    end
  end
end
