# frozen_string_literal: true
require 'rest-client'

require 'paymaya/helper'

module Paymaya
  module PaymentVault
    module CardVault
      class Subscription
        def create(customer_id, card_token, payment)
          Helper.request(:post,
            customer_subscription_url(customer_id, card_token),
            payment, Helper.payment_vault_secret_auth_headers)
        end

        def list(customer_id, card_token)
          Helper.request(:get,
            customer_subscription_url(customer_id, card_token),
            {}, Helper.payment_vault_secret_auth_headers)
        end

        def retrieve(id)
          Helper.request(:get, subscription_url(id), {},
            Helper.payment_vault_secret_auth_headers)
        end

        def delete(id)
          Helper.request(:delete, subscription_url(id), {},
            Helper.payment_vault_secret_auth_headers)
        end

        def list_payments(id)
          Helper.request(:get, "#{subscription_url(id)}/payments", {},
            Helper.payment_vault_secret_auth_headers)
        end

        def customer_subscription_url(customer_id, card_token)
          "#{Paymaya.config.base_url}/payments/v1/customers/#{customer_id}/" \
          "cards/#{card_token}/subscriptions"
        end

        def subscription_url(id)
          "#{Paymaya.config.base_url}/payments/v1/subscriptions/#{id}"
        end

        private :subscription_url
      end
    end
  end
end
