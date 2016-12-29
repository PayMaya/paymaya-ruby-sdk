require 'rest-client'

require 'paymaya/helper'

module Paymaya
  module PaymentVault
    module CardVault
      class Subscription
        def create(customer_id, card_token, payment)
          response = RestClient.post(customer_subscription_url(customer_id, card_token),
            Helper.camelify(payment).to_json, auth_headers)
          Helper.snakify(JSON.parse(response))
        end

        def list(customer_id, card_token)
          response = RestClient.get(customer_subscription_url(customer_id, card_token),
            auth_headers)
          Helper.snakify(JSON.parse(response))
        end

        def retrieve(id)
          response = RestClient.get(subscription_url(id),
            auth_headers)
          Helper.snakify(JSON.parse(response))
        end

        def customer_subscription_url(customer_id, card_token)
          "#{Paymaya.config.base_url}/payments/v1/customers/#{customer_id}/cards/#{card_token}/subscriptions"
        end

        def subscription_url(id)
          "#{Paymaya.config.base_url}/payments/v1/subscriptions/#{id}"
        end

        def auth_headers
          {
            authorization:
              "Basic #{Base64.strict_encode64(Paymaya.config.secret_key + ':').chomp}",
            content_type: 'application/json'
          }
        end

        private :subscription_url, :auth_headers
      end
    end
  end
end
