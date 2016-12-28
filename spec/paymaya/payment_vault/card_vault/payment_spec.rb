require 'spec_helper'
require 'awrence'

describe Paymaya::PaymentVault::CardVault::Payment do
  let(:public_key) { 'pk-8rOz4MQKRxd5OLKBPcR6FIUx4Kay71kB3UrBFDaH172' }
  let(:secret_key) { 'sk-VrEDVetYZ6f4R1w4g0npwLzeBXtksd1smJ5lqk9Yh4y' }

  let(:base_url) { 'https://pg-sandbox.paymaya.com' }

  let(:valid_payment) do
    {
      "totalAmount": {
        "amount": 150,
        "currency": 'PHP'
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
      VCR.use_cassette('create_payment') do
        payment = subject.create(valid_payment)
        expect(payment).to include :id
      end
    end
  end
end
