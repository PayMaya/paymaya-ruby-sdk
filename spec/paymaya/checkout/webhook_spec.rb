# frozen_string_literal: true
require 'spec_helper'

describe Paymaya::Checkout::Webhook do
  let(:secret_key) { 'sk-VrEDVetYZ6f4R1w4g0npwLzeBXtksd1smJ5lqk9Yh4y' }

  let(:base_url) { 'https://pg-sandbox.paymaya.com' }

  let(:valid_webhook) do
    {
      name: 'CHECKOUT_DROPOUT',
      callback_url: 'http://userwebsite.com/dropout'
    }
  end

  before :example do
    allow(Paymaya).to receive(:config).and_return(
      double(
        base_url: base_url,
        secret_key: secret_key
      )
    )
  end

  describe '#register' do
    it 'registers a webhook' do
      VCR.use_cassette('register_checkout_webhook') do
        registered = subject.register(valid_webhook)
        expect(registered).to include :name
        expect(registered).to include :callback_url
        expect(registered).to include :id
      end
    end
  end

  describe '#list' do
    it 'retrieves the webhooks from <base_url>/checkout/v1/webhooks' do
      VCR.use_cassette('list_checkout_webhooks') do
        webhooks = subject.list
        expect(webhooks[0]).to include :name
        expect(webhooks[0]).to include :callback_url
        expect(webhooks[0]).to include :id
      end
    end
  end

  describe '#delete' do
    it 'deletes the registered webhook' do
      VCR.use_cassette('delete_checkout_webhook') do
        id = 'd1145ee5-53ac-414a-b5d2-10efd5fd1acb'
        deleted = subject.delete(id)
        expect(deleted[:id]).to eq id
      end
    end
  end

  describe '#update' do
    it 'updates the registered webhook' do
      VCR.use_cassette('update_checkout_webhook') do
        id = 'd1145ee5-53ac-414a-b5d2-10efd5fd1acb'
        deleted = subject.update(id,
          name: 'CHECKOUT_DROPOUT',
          callback_url: 'http://userwebsite.com/checkout_droupout')
        expect(deleted[:id]).to eq id
      end
    end
  end
end
