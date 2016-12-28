require 'spec_helper'
require 'awrence'

describe Paymaya::PaymentVault::PaymentToken do
  let(:public_key) { 'pk-8rOz4MQKRxd5OLKBPcR6FIUx4Kay71kB3UrBFDaH172' }
  let(:secret_key) { 'sk-VrEDVetYZ6f4R1w4g0npwLzeBXtksd1smJ5lqk9Yh4y' }

  let(:base_url) { 'https://pg-sandbox.paymaya.com' }

  let(:valid_payment_token) do
    {
      card: {
        number: '5123456789012346',
        expMonth: '05',
        expYear: '2017',
        cvc: '111'
      }
    }.to_snake_keys
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

  describe '#create' do
    it do
      VCR.use_cassette('create_payment_token') do
        payment_token = subject.create(valid_payment_token)
        expect(payment_token).to include :payment_token_id
      end
    end
  end
end
