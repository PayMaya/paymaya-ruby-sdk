# frozen_string_literal: true
require 'rest-client'

require 'paymaya/helper'

module Paymaya
  module PaymentVault
    module CardVault
      module Subscription
        def self.create(customer_id, card_token, payment)
          Helper.request(:post,
            customer_subscription_url(customer_id, card_token),
            payment, Helper.payment_vault_secret_auth_headers)
        end

        def self.list(customer_id, card_token)
          Helper.request(:get,
            customer_subscription_url(customer_id, card_token),
            {}, Helper.payment_vault_secret_auth_headers)
        end

        def self.retrieve(id)
          Helper.request(:get, subscription_url(id), {},
            Helper.payment_vault_secret_auth_headers)
        end

        def self.delete(id)
          Helper.request(:delete, subscription_url(id), {},
            Helper.payment_vault_secret_auth_headers)
        end

        def self.list_payments(id)
          Helper.request(:get, "#{subscription_url(id)}/payments", {},
            Helper.payment_vault_secret_auth_headers)
        end

        def self.customer_subscription_url(customer_id, card_token)
          "#{Paymaya.config.base_url}/payments/v1/customers/#{customer_id}/" \
          "cards/#{card_token}/subscriptions"
        end

        def self.subscription_url(id)
          "#{Paymaya.config.base_url}/payments/v1/subscriptions/#{id}"
        end

        private_class_method :subscription_url
      end
    end
  end
end
