# frozen_string_literal: true
require 'rest-client'

require 'paymaya/helper'

module Paymaya
  module PaymentVault
    module CardVault
      class Payment
        def create(customer_id, card_token, payment)
          response = RestClient.post(payment_url(customer_id, card_token),
            Helper.camelify(payment).to_json, auth_headers)
          Helper.snakify(JSON.parse(response))
        end

        def payment_url(customer_id, card_token)
          "#{Paymaya.config.base_url}/payments/v1/customers/#{customer_id}/cards/#{card_token}/payments"
        end

        def auth_headers
          {
            authorization:
              "Basic #{Base64.strict_encode64(Paymaya.config.payment_vault_secret_key + ':').chomp}",
            content_type: 'application/json'
          }
        end

        private :payment_url, :auth_headers
      end
    end
  end
end
