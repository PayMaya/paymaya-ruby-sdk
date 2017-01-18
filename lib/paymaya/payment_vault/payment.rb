# frozen_string_literal: true
require 'rest-client'

require 'paymaya/helper'

module Paymaya
  module PaymentVault
    module Payment
      def self.create(payment_token_id:, total_amount:, buyer:,
        metadata: nil)
        payload = {
          total_amount: total_amount,
          buyer: buyer,
          payment_token_id: payment_token_id
        }
        payload[:metadata] = metadata unless metadata.nil?
        Helper.request(:post, payment_url, payload,
          Helper.payment_vault_secret_auth_headers)
      end

      def self.retrieve(id)
        Helper.request(:get, "#{payment_url}/#{id}", {},
          Helper.payment_vault_secret_auth_headers)
      end

      def self.void(id, reason)
        Helper.request(:delete, "#{payment_url}/#{id}", {
          reason: reason
        }, Helper.payment_vault_secret_auth_headers)
      end

      def self.refund(id, total_amount, reason)
        payload = {
          total_amount: total_amount,
          reason: reason
        }
        Helper.request(:post, "#{payment_url}/#{id}/refunds",
          payload, Helper.payment_vault_secret_auth_headers)
      end

      def self.list_refunds(id)
        Helper.request(:get, "#{payment_url}/#{id}/refunds",
          {}, Helper.payment_vault_secret_auth_headers)
      end

      def self.retrieve_refund(payment, id)
        Helper.request(:get, "#{payment_url}/#{payment}/refunds/#{id}",
          {}, Helper.payment_vault_secret_auth_headers)
      end

      def self.payment_url
        "#{Paymaya.config.base_url}/payments/v1/payments"
      end

      private_class_method :payment_url
    end
  end
end
