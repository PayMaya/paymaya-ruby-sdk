require 'spec_helper'
require 'webmock/rspec'
require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = "fixtures/vcr_cassettes"
  config.hook_into :webmock # or :fakeweb
end

describe Paymaya::Checkout::Webhook do
  let(:private_key) { 'private-key' }
  let(:secret_key) { 'sk-VrEDVetYZ6f4R1w4g0npwLzeBXtksd1smJ5lqk9Yh4y' }

  let(:base_url) { 'https://pg-sandbox.paymaya.com' }
  let(:webhooks_url) { "#{base_url}/checkout/v1/webhooks" }

  let(:valid_webhook) do
    {
      name: 'CHECKOUT_DROPOUT',
      callback_url: 'http://userwebsite.com/dropout'
    }
  end

  let(:key_header) { "Basic #{Base64.strict_encode64(key).chomp}" }

  before :example do
    allow(Paymaya).to receive(:config).and_return(
      double(
        base_url: base_url,
        private_key: private_key,
        secret_key: secret_key
      )
    )
  end

  describe '#register' do
    let(:key) { secret_key }

    it 'registers a webhook' do
      VCR.use_cassette('register_webhook') do
        registered = subject.register(valid_webhook)
        expect(registered).to include :name
        expect(registered).to include :callback_url
        expect(registered).to include :id
      end
    end
  end

  describe '#retrieve' do
    it 'retrieves the webhooks from <base_url>/checkout/v1/webhooks' do
      VCR.use_cassette('retrieve_webhooks') do
        webhooks = subject.retrieve
        expect(webhooks[0]).to include :name
        expect(webhooks[0]).to include :callback_url
        expect(webhooks[0]).to include :id
      end
    end
  end

  describe '#delete' do
    it 'deletes the registered webhook' do
      VCR.use_cassette('delete_webhook') do
        id = 'f6be27a8-3b96-4cf4-bcfc-7b86f5e7c93d'
        deleted = subject.delete(id)
        expect(deleted[:id]).to eq id
      end
    end
  end
end
