require 'rest-client'

require 'paymaya/helper'

module Paymaya
  module PaymentVault
    class Payment
      def create(payment_token_id:, total_amount:, buyer:,
        metadata: nil)
        payload = {
          total_amount: total_amount,
          buyer: buyer,
          payment_token_id: payment_token_id
        }
        payload[:metadata] = metadata unless metadata.nil?
        response = RestClient.post(payment_url, payload.to_camelback_keys.to_json, auth_headers)
        Helper.snakify(JSON.parse(response))
      end

      def retrieve(id)
        response = RestClient.get("#{payment_url}/#{id}", auth_headers)
        Helper.snakify(JSON.parse(response))
      end

      def void(id, reason)
        response = RestClient::Request.execute(
          method: :delete, url: "#{payment_url}/#{id}",
          headers: auth_headers, payload: {
            reason: reason
          }.to_json
        )
        Helper.snakify(JSON.parse(response))
      end

      def payment_url
        "#{Paymaya.config.base_url}/payments/v1/payments"
      end

      def auth_headers
        {
          authorization:
            "Basic #{Base64.strict_encode64(Paymaya.config.secret_key + ':').chomp}",
          content_type: 'application/json'
        }
      end

      private :payment_url, :auth_headers
    end
  end
end