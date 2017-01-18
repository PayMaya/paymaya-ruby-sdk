# frozen_string_literal: true
require 'rest-client'

require 'paymaya/helper'

module Paymaya
  module PaymentVault
    module CardVault
      module Payment
        def self.create(customer_id, card_token, payment)
          Helper.request(:post, payment_url(customer_id, card_token),
            payment, Helper.payment_vault_secret_auth_headers)
        end

        def self.payment_url(customer_id, card_token)
          "#{Paymaya.config.base_url}/payments/v1/customers/#{customer_id}/" \
          "cards/#{card_token}/payments"
        end

        private_class_method :payment_url
      end
    end
  end
end
