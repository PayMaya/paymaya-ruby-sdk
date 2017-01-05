# frozen_string_literal: true
require 'spec_helper'

describe Paymaya::PaymentVault::CardVault::Payment do
  let(:public_key) { 'pk-EpTu7LXv8mwuONutYflskyYdqRSx1Ing9K3V3JtBRqB' }
  let(:secret_key) { 'sk-GgVT0xX7YJcWBauR4UqnMkyFt8GpksixEUaV7qWnDJc' }

  let(:base_url) { 'https://pg-sandbox.paymaya.com' }

  let(:valid_payment) do
    {
      total_amount: {
        amount: 150,
        currency: 'PHP'
      }
    }
  end

  let(:customer_id) { '5f39f980-225f-4805-b61f-50e84ce3fcdf' }
  let(:card_token) { 'wdi6mkRvsaLNTiTOoMJD3GLUrdC0SdBvr7e6LbJvjxU2gjdr5k9Gynj0GQN7f9fofsDBlqy0Zzq6u4Vwhfd8hug0dCQo3NSb3RDV2GndnhmSEkKoY4eoAlxYaZUtJ4mFObMGGHxPmTaXZC9rBuPXe5JIZwFkzz5X1SXU' }

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
      VCR.use_cassette('create_card_vault_payment') do
        payment = subject.create(customer_id, card_token, valid_payment)
        expect(payment).to include :id
      end
    end
  end
end
