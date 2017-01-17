# frozen_string_literal: true
require 'spec_helper'
require 'paymaya/helper'

describe Paymaya::PaymentVault::Webhook do
  let(:public_key) { 'pk-EpTu7LXv8mwuONutYflskyYdqRSx1Ing9K3V3JtBRqB' }
  let(:secret_key) { 'sk-GgVT0xX7YJcWBauR4UqnMkyFt8GpksixEUaV7qWnDJc' }

  let(:base_url) { 'https://pg-sandbox.paymaya.com' }

  let(:valid_webhook) do
    {
      name: '3DS_PAYMENT_SUCCESS',
      callback_url: 'http://shop.someserver.com/success'
    }
  end

  before :example do
    allow(Paymaya).to receive(:config).and_return(
      double(
        base_url: base_url,
        payment_vault_secret_key: secret_key,
        payment_vault_public_key: public_key
      )
    )
  end

  describe '#register' do
    it do
      VCR.use_cassette('register_payment_vault_webhook') do
        webhook = subject.register(valid_webhook)
        expect(webhook).to include :id
      end
    end
  end

  describe '#list' do
    it do
      VCR.use_cassette('list_payment_vault_webhooks') do
        webhook = subject.list[0]
        expect(webhook).to include :id
      end
    end
  end

  describe '#retrieve' do
    it do
      VCR.use_cassette('retrieve_payment_vault_webhook') do
        id = '674a08c7-e68e-4386-a5cb-750db1d3675a'
        webhook = subject.retrieve(id)
        expect(webhook).to include :id
      end
    end
  end

  describe '#update' do
    it do
      VCR.use_cassette('update_payment_vault_webhook') do
        id = '674a08c7-e68e-4386-a5cb-750db1d3675a'
        webhook = subject.update(id, valid_webhook)
        expect(webhook).to include :id
      end
    end
  end

  describe '#delete' do
    it do
      VCR.use_cassette('delete_payment_vault_webhook') do
        id = '674a08c7-e68e-4386-a5cb-750db1d3675a'
        webhook = subject.delete(id)
        expect(webhook).to include :id
      end
    end
  end
end
