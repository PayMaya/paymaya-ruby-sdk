# frozen_string_literal: true
require 'spec_helper'

describe Paymaya do
  let(:sandbox_base_url) { 'https://pg-sandbox.paymaya.com' }
  let(:prod_base_url) { 'https://pg.paymaya.com' }

  it 'has a version number' do
    expect(Paymaya::VERSION).not_to be nil
  end

  describe '#configure' do
    describe 'base_url' do
      it 'defaults to the sandbox URL' do
        expect(subject.config.base_url).to eq sandbox_base_url
      end

      describe 'when config.mode = :sandbox' do
        before :example do
          Paymaya.configure do |config|
            config.mode = :sandbox
            config.base_url = nil
          end
        end
        it 'returns the sandbox URL' do
          expect(subject.config.base_url).to eq sandbox_base_url
        end
      end

      describe 'when config.mode = :prod' do
        before :example do
          Paymaya.configure do |config|
            config.mode = :prod
            config.base_url = nil
          end
        end
        it 'returns the prod URL' do
          expect(subject.config.base_url).to eq prod_base_url
        end
      end

      it 'is set by .configure' do
        expect do
          Paymaya.configure do |config|
            config.base_url = 'base_url'
          end
        end.to change { subject.config.base_url }
          .to('base_url')
      end
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
