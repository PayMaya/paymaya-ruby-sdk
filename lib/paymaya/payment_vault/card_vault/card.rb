# frozen_string_literal: true
require 'rest-client'

require 'paymaya/helper'

module Paymaya
  module PaymentVault
    module CardVault
      module Card
        def self.create(customer_id, card)
          Helper.request(:post, card_url(customer_id),
            card, Helper.payment_vault_secret_auth_headers)
        end

        def self.list(customer_id)
          Helper.request(:get, card_url(customer_id), {},
            Helper.payment_vault_secret_auth_headers)
        end

        def self.retrieve(customer_id, id)
          Helper.request(:get, "#{card_url(customer_id)}/#{id}", {},
            Helper.payment_vault_secret_auth_headers)
        end

        def self.delete(customer_id, id)
          Helper.request(:delete, "#{card_url(customer_id)}/#{id}", {},
            Helper.payment_vault_secret_auth_headers)
        end

        def self.update(customer_id, id, card)
          Helper.request(:put, "#{card_url(customer_id)}/#{id}",
            card, Helper.payment_vault_secret_auth_headers)
        end

        def self.card_url(customer_id)
          "#{Paymaya.config.base_url}/payments/v1/customers/#{customer_id}/" \
          'cards'
        end

        private_class_method :card_url
      end
    end
  end
end
