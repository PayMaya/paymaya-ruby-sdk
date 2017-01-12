require 'rest-client'

require 'paymaya/helper'

module Paymaya
  module PaymentVault
    class Webhook
      def register(name:, callback_url:)
        response = RestClient.post(webhook_url, {
          name: name,
          callback_url: callback_url
        }.to_camelback_keys.to_json, auth_headers)
        Helper.snakify(JSON.parse(response))
      end

      def list
        response = RestClient.get(webhook_url, auth_headers)
        Helper.snakify(JSON.parse(response))
      end

      def retrieve(id)
        response = RestClient.get("#{webhook_url}/#{id}", auth_headers)
        Helper.snakify(JSON.parse(response))
      end

      def delete(id)
        response = RestClient.delete("#{webhook_url}/#{id}", auth_headers)
        Helper.snakify(JSON.parse(response))
      end

      def update(id, name:, callback_url:)
        response = RestClient.put("#{webhook_url}/#{id}", {
          name: name,
          callbackUrl: callback_url
        }.to_json, auth_headers)
        Helper.snakify(JSON.parse(response))
      end

      def webhook_url
        "#{Paymaya.config.base_url}/payments/v1/webhooks"
      end

      def auth_headers
        {
          authorization:
            "Basic #{Base64.strict_encode64(Paymaya.config.payment_vault_secret_key + ':').chomp}",
          content_type: 'application/json'
        }
      end

      private :webhook_url, :auth_headers
    end
  end
end
