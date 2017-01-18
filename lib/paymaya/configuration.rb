# frozen_string_literal: true
module Paymaya
  class Configuration
    attr_accessor :payment_vault_public_key, :payment_vault_secret_key,
      :checkout_public_key, :checkout_secret_key
    attr_writer :base_url, :mode

    SANDBOX_BASE_URL = 'https://pg-sandbox.paymaya.com'.freeze
    PROD_BASE_URL = 'https://pg.paymaya.com'.freeze

    def base_url
      return @base_url unless @base_url.nil?
      return SANDBOX_BASE_URL if mode == :sandbox
      PROD_BASE_URL
    end

    def mode
      return @mode unless @mode.nil?
      :sandbox
    end
  end
end
