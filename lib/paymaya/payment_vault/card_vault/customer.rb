# frozen_string_literal: true
require 'rest-client'

require 'paymaya/helper'

module Paymaya
  module PaymentVault
    module CardVault
      module Customer
        def self.create(customer)
          Helper.request(:post, customer_url,
            customer, Helper.payment_vault_secret_auth_headers)
        end

        def self.retrieve(id)
          Helper.request(:get, "#{customer_url}/#{id}", {},
            Helper.payment_vault_secret_auth_headers)
        end

        def self.delete(id)
          Helper.request(:delete, "#{customer_url}/#{id}", {},
            Helper.payment_vault_secret_auth_headers)
        end

        def self.update(id, customer)
          Helper.request(:put, "#{customer_url}/#{id}",
            customer, Helper.payment_vault_secret_auth_headers)
        end

        def self.customer_url
          "#{Paymaya.config.base_url}/payments/v1/customers"
        end

        private_class_method :customer_url
      end
    end
  end
end
