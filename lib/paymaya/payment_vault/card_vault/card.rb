# frozen_string_literal: true
require 'rest-client'

require 'paymaya/helper'

module Paymaya
  module PaymentVault
    module CardVault
      class Card
        def create(customer_id, card)
          response = RestClient.post(card_url(customer_id),
            Helper.camelify(card).to_json, auth_headers)
          Helper.snakify(JSON.parse(response))
        end

        def list(customer_id)
          response = RestClient.get(card_url(customer_id),
            auth_headers)
          Helper.snakify(JSON.parse(response))
        end

        def retrieve(customer_id, id)
          response = RestClient.get("#{card_url(customer_id)}/#{id}",
            auth_headers)
          Helper.snakify(JSON.parse(response))
        end

        def delete(customer_id, id)
          response = RestClient.delete("#{card_url(customer_id)}/#{id}",
            auth_headers)
          Helper.snakify(JSON.parse(response))
        end

        def update(customer_id, id, card)
          response = RestClient.put("#{card_url(customer_id)}/#{id}",
            Helper.camelify(card).to_json, auth_headers)
          Helper.snakify(JSON.parse(response))
        end

        def card_url(customer_id)
          "#{Paymaya.config.base_url}/payments/v1/customers/#{customer_id}/cards"
        end

        def auth_headers
          {
            authorization:
              "Basic #{Base64.strict_encode64(Paymaya.config.secret_key + ':').chomp}",
            content_type: 'application/json'
          }
        end

        private :card_url, :auth_headers
      end
    end
  end
end
