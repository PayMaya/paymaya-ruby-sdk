# frozen_string_literal: true
require 'rest-client'
require 'paymaya/helper'

module Paymaya
  module PaymentVault
    module Webhook
      def self.register(name:, callback_url:)
        Helper.request(:post, webhook_url, {
          name: name,
          callback_url: callback_url
        }, Helper.payment_vault_secret_auth_headers)
      end

      def self.list
        Helper.request(:get, webhook_url, {},
          Helper.payment_vault_secret_auth_headers)
      end

      def self.retrieve(id)
        Helper.request(:get, "#{webhook_url}/#{id}", {},
          Helper.payment_vault_secret_auth_headers)
      end

      def self.delete(id)
        Helper.request(:delete, "#{webhook_url}/#{id}", {},
          Helper.payment_vault_secret_auth_headers)
      end

      def self.update(id, name:, callback_url:)
        Helper.request(:put, "#{webhook_url}/#{id}", {
          name: name,
          callbackUrl: callback_url
        }, Helper.payment_vault_secret_auth_headers)
      end

      def self.webhook_url
        "#{Paymaya.config.base_url}/payments/v1/webhooks"
      end

      private_class_method :webhook_url
    end
  end
end
