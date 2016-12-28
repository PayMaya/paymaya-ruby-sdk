require 'spec_helper'
require 'awrence'

describe Paymaya::PaymentVault::CardVault::Payment do
  let(:public_key) { 'pk-Xu1VAKiNdLj3fyQ7MT4kRYAQ5Oe0RjBcbN5MfcRevSn' }
  let(:secret_key) { 'sk-dOxQfFiCZ7ImhHAsLLTVPpuVt3XBtqPzbcpeJa3TBJv' }

  let(:base_url) { 'https://pg-sandbox.paymaya.com' }

  let(:valid_payment) do
    {
      total_amount: {
        amount: 150,
        currency: 'PHP'
      }
    }
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
