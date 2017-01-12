require 'spec_helper'

describe Paymaya do
  it 'has a version number' do
    expect(Paymaya::VERSION).not_to be nil
  end

  describe '#configure' do
    it 'configures base_url' do
      expect do
        Paymaya.configure do |config|
          config.base_url = 'base_url'
        end
      end.to change { subject.config.base_url }
        .to('base_url')
    end

    it 'configures payment_vault_secret_key' do
      expect do
        Paymaya.configure do |config|
          config.payment_vault_secret_key = 'payment_vault_secret_key'
        end
      end.to change { subject.config.payment_vault_secret_key }
        .to('payment_vault_secret_key')
    end

    it 'configures payment_vault_public_key' do
      expect do
        Paymaya.configure do |config|
          config.payment_vault_public_key = 'payment_vault_public_key'
        end
      end.to change { subject.config.payment_vault_public_key }
        .to('payment_vault_public_key')
    end

    it 'configures checkout_secret_key' do
      expect do
        Paymaya.configure do |config|
          config.checkout_secret_key = 'checkout_secret_key'
        end
      end.to change { subject.config.checkout_secret_key }
        .to('checkout_secret_key')
    end

    it 'configures checkout_public_key' do
      expect do
        Paymaya.configure do |config|
          config.checkout_public_key = 'checkout_public_key'
        end
      end.to change { subject.config.checkout_public_key }
        .to('checkout_public_key')
    end
  end
end
