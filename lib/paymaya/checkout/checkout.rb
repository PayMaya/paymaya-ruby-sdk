# frozen_string_literal: true
require 'rest-client'

require 'paymaya/helper'

module Paymaya
  module Checkout
    module Checkout
      def self.create(total_amount:, buyer:, items:, redirect_url: nil,
        request_reference_number: nil, metadata: nil)
        payload = { total_amount: total_amount, buyer: buyer,
                    items: Helper.camelify(items) }
        payload[:redirect_url] = redirect_url unless redirect_url.nil?
        unless request_reference_number.nil?
          payload[:request_reference_number] = request_reference_number
        end
        payload[:metadata] = metadata unless metadata.nil?
        Helper.request(:post, checkout_url, payload,
          Helper.checkout_public_auth_headers)
      end

      def self.retrieve(id)
        Helper.request(:get, "#{checkout_url}/#{id}", {},
          Helper.checkout_secret_auth_headers)
      end

      def self.checkout_url
        "#{Paymaya.config.base_url}/checkout/v1/checkouts"
      end

      private_class_method :checkout_url
    end
  end
end
