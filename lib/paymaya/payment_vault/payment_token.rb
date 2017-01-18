# frozen_string_literal: true
require 'rest-client'
require 'paymaya/helper'

module Paymaya
  module PaymentVault
    module PaymentToken
      def self.create(card)
        Helper.request(:post, payment_token_url, card,
          Helper.payment_vault_public_auth_headers)
      end

      def self.payment_token_url
        "#{Paymaya.config.base_url}/payments/v1/payment-tokens"
      end

      private_class_method :payment_token_url
    end
  end
end
