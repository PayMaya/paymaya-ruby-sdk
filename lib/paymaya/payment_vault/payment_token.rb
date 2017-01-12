require 'rest-client'
require 'paymaya/helper'

module Paymaya
  module PaymentVault
    class PaymentToken
      def create(card)
        response = RestClient.post(payment_token_url, Helper.camelify(card).to_json, auth_headers)
        Helper.snakify(JSON.parse(response))
      end

      def payment_token_url
        "#{Paymaya.config.base_url}/payments/v1/payment-tokens"
      end

      def auth_headers
        {
          authorization:
            "Basic #{Base64.strict_encode64(Paymaya.config.payment_vault_public_key + ':').chomp}",
          content_type: 'application/json'
        }
      end

      private :payment_token_url, :auth_headers
    end
  end
end
