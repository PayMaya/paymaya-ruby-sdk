require 'rest-client'

require 'paymaya/helper'

module Paymaya
  module PaymentVault
    module CardVault
      class Customer
        def create(customer)
          response = RestClient.post(customer_url,
            Helper.camelify(customer).to_json, auth_headers)
          Helper.snakify(JSON.parse(response))
        end

        def retrieve(id)
          response = RestClient.get("#{customer_url}/#{id}", auth_headers)
          Helper.snakify(JSON.parse(response))
        end

        def delete(id)
          response = RestClient.delete("#{customer_url}/#{id}", auth_headers)
          Helper.snakify(JSON.parse(response))
        end

        def update(id, customer)
          response = RestClient.put("#{customer_url}/#{id}",
            Helper.camelify(customer).to_json, auth_headers)
          Helper.snakify(JSON.parse(response))
        end

        def customer_url
          "#{Paymaya.config.base_url}/payments/v1/customers"
        end

        def auth_headers
          {
            authorization:
              "Basic #{Base64.strict_encode64(Paymaya.config.payment_vault_secret_key + ':').chomp}",
            content_type: 'application/json'
          }
        end

        private :customer_url, :auth_headers
      end
    end
  end
end
