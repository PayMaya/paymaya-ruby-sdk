require 'spec_helper'
require 'awrence'

describe Paymaya::PaymentVault::CardVault::Subscription do
  let(:public_key) { 'pk-8rOz4MQKRxd5OLKBPcR6FIUx4Kay71kB3UrBFDaH172' }
  let(:secret_key) { 'sk-VrEDVetYZ6f4R1w4g0npwLzeBXtksd1smJ5lqk9Yh4y' }

  let(:base_url) { 'https://pg-sandbox.paymaya.com' }

  let(:valid_subscription) do
    {
      "description": "Test subscription",
      "interval": "DAY",
      "intervalCount": 1,
      "startDate": "2016-07-07",
      "endDate": null,
      "totalAmount": {
        "amount": 100,
        "currency": "PHP"
      }
    }.to_snake_keys
  end

  let(:card_id) { '' }
  let(:customer_id) { '' }

  before :example do
    allow(Paymaya).to receive(:config).and_return(
      double(
        base_url: base_url,
        secret_key: secret_key,
        public_key: public_key
      )
    )
  end

  describe '#create' do
    it do
      VCR.use_cassette('create_subscription') do
        subscription = subject.create(valid_subscription)
        expect(subscription).to include :id
      end
    end
  end

  describe '#list' do
    it do
      VCR.use_cassette('list_subscriptions') do
        id = ''
        subscription = subject.list(id)
        expect(subscription).to include :state
      end
    end
  end

  describe '#retrieve' do
    it do
      VCR.use_cassette('retrieve_subscription') do
        id = ''
        subscription = subject.retrieve(id)
        expect(subscription).to include :state
      end
    end
  end

  describe '#list_payments' do
    it do
      VCR.use_cassette('list_subscription_payments') do
        id = ''
        subscription = subject.update(id, valid_subscription_update)
        expect(subscription).to include :state
      end
    end
  end

  describe '#delete' do
    it do
      VCR.use_cassette('delete_subscription') do
        id = ''
        subscription = subject.delete(id)
        expect(subscription).to include :state
      end
    end
  end
end
