# frozen_string_literal: true
require 'rest-client'

require 'paymaya/helper'

module Paymaya
  module Checkout
    class Checkout
      def create(total_amount:, buyer:, items:, redirect_url: nil,
        request_reference_number: nil, metadata: nil)
        payload = {
          total_amount: total_amount,
          buyer: buyer,
          items: Helper.camelify(items)
        }
        payload[:redirect_url] = redirect_url unless redirect_url.nil?
        unless request_reference_number.nil?
          payload[:request_reference_number] = request_reference_number
        end
        payload[:metadata] = metadata unless metadata.nil?
        response = RestClient.post(checkout_url, payload.to_camelback_keys.to_json, auth_headers_2)
        Helper.snakify(JSON.parse(response))
      end

      def retrieve(id)
        response = RestClient.get("#{checkout_url}/#{id}", auth_headers)
        Helper.snakify(JSON.parse(response))
      end

      def checkout_url
        "#{Paymaya.config.base_url}/checkout/v1/checkouts"
      end

      def auth_headers
        {
          authorization:
            "Basic #{Base64.strict_encode64(Paymaya.config.checkout_secret_key + ':').chomp}",
          content_type: 'application/json'
        }
      end

      def auth_headers_2
        {
          authorization:
            "Basic #{Base64.strict_encode64(Paymaya.config.checkout_public_key + ':').chomp}",
          content_type: 'application/json'
        }
      end

      private :checkout_url, :auth_headers
    end
  end
end
