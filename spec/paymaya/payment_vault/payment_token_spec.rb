require 'spec_helper'

describe Paymaya::PaymentVault::PaymentToken do
  let(:public_key) { 'pk-EpTu7LXv8mwuONutYflskyYdqRSx1Ing9K3V3JtBRqB' }
  let(:secret_key) { 'sk-GgVT0xX7YJcWBauR4UqnMkyFt8GpksixEUaV7qWnDJc' }

  let(:base_url) { 'https://pg-sandbox.paymaya.com' }

  let(:valid_payment_token) do
    {
      card: {
        number: '5123456789012346',
        exp_month: '05',
        exp_year: '2017',
        cvc: '111'
      }
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

  describe '#create' do
    it do
      VCR.use_cassette('create_payment_token') do
        payment_token = subject.create(valid_payment_token)
        expect(payment_token).to include :payment_token_id
      end
    end
  end
end
