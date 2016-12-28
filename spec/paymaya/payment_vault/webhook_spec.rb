require 'spec_helper'

describe Paymaya::PaymentVault::Webhook do
  let(:public_key) { 'pk-8rOz4MQKRxd5OLKBPcR6FIUx4Kay71kB3UrBFDaH172' }
  let(:secret_key) { 'sk-VrEDVetYZ6f4R1w4g0npwLzeBXtksd1smJ5lqk9Yh4y' }

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
        secret_key: secret_key,
        public_key: public_key
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
        id = ''
        webhook = subject.retrieve(id)
        expect(webhook).to include :id
      end
    end
  end

  describe '#update' do
    it do
      VCR.use_cassette('update_payment_vault_webhook') do
        id = ''
        webhook = subject.update(id, valid_webhook)
        expect(webhook).to include :state
      end
    end
  end

  describe '#delete' do
    it do
      VCR.use_cassette('delete_payment_vault_webhook') do
        id = ''
        webhook = subject.delete(id)
        expect(webhook).to include :id
      end
    end
  end
end
