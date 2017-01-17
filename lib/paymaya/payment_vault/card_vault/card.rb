# frozen_string_literal: true
require 'rest-client'

require 'paymaya/helper'

module Paymaya
  module PaymentVault
    module CardVault
      class Card
        def create(customer_id, card)
          Helper.request(:post, card_url(customer_id),
            card, Helper.payment_vault_secret_auth_headers)
        end

        def list(customer_id)
          Helper.request(:get, card_url(customer_id), {},
            Helper.payment_vault_secret_auth_headers)
        end

        def retrieve(customer_id, id)
          Helper.request(:get, "#{card_url(customer_id)}/#{id}", {},
            Helper.payment_vault_secret_auth_headers)
        end

        def delete(customer_id, id)
          Helper.request(:delete, "#{card_url(customer_id)}/#{id}", {},
            Helper.payment_vault_secret_auth_headers)
        end

        def update(customer_id, id, card)
          Helper.request(:put, "#{card_url(customer_id)}/#{id}",
            card, Helper.payment_vault_secret_auth_headers)
        end

        def card_url(customer_id)
          "#{Paymaya.config.base_url}/payments/v1/customers/#{customer_id}/" \
          'cards'
        end

        private :card_url
      end
    end
  end
end
