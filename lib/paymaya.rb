require 'paymaya/version'
require 'paymaya/helper'
require 'paymaya/configuration'
require 'paymaya/checkout/webhook'
require 'paymaya/checkout/customization'
require 'paymaya/checkout/checkout'
require 'paymaya/payment_vault/card_vault/customer'
require 'paymaya/payment_vault/card_vault/card'
require 'paymaya/payment_vault/card_vault/payment'
require 'paymaya/payment_vault/card_vault/subscription'
require 'paymaya/payment_vault/payment'
require 'paymaya/payment_vault/payment_token'
require 'paymaya/payment_vault/webhook'

module Paymaya
  class << self
    attr_accessor :configuration
  end

  def self.config
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end
