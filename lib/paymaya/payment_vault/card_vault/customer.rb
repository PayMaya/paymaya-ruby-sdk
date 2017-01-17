# frozen_string_literal: true
require 'rest-client'

require 'paymaya/helper'

module Paymaya
  module PaymentVault
    module CardVault
      class Customer
        def create(customer)
          Helper.request(:post, customer_url,
            customer, Helper.payment_vault_secret_auth_headers)
        end

        def retrieve(id)
          Helper.request(:get, "#{customer_url}/#{id}", {},
            Helper.payment_vault_secret_auth_headers)
        end

        def delete(id)
          Helper.request(:delete, "#{customer_url}/#{id}", {},
            Helper.payment_vault_secret_auth_headers)
        end

        def update(id, customer)
          Helper.request(:put, "#{customer_url}/#{id}",
            customer, Helper.payment_vault_secret_auth_headers)
        end

        def customer_url
          "#{Paymaya.config.base_url}/payments/v1/customers"
        end

        private :customer_url
      end
    end
  end
end
