# frozen_string_literal: true
require 'spec_helper'

describe Paymaya::PaymentVault::CardVault::Subscription do
  let(:public_key) { 'pk-EpTu7LXv8mwuONutYflskyYdqRSx1Ing9K3V3JtBRqB' }
  let(:secret_key) { 'sk-GgVT0xX7YJcWBauR4UqnMkyFt8GpksixEUaV7qWnDJc' }

  let(:base_url) { 'https://pg-sandbox.paymaya.com' }

  let(:valid_subscription) do
    {
      description: 'Test subscription',
      interval: 'DAY',
      interval_count: 1,
      start_date: '2016-12-30',
      end_date: nil,
      total_amount: {
        amount: 100,
        currency: 'PHP'
      }
    }
  end

  let(:customer_id) { '5f39f980-225f-4805-b61f-50e84ce3fcdf' }
  let(:card_token) do
    'wdi6mkRvsaLNTiTOoMJD3GLUrdC0SdBvr7e6LbJvjxU2gjdr5k9Gynj0GQN7f9fofsDBlqy0' \
    'Zzq6u4Vwhfd8hug0dCQo3NSb3RDV2GndnhmSEkKoY4eoAlxYaZUtJ4mFObMGGHxPmTaXZC9r' \
    'BuPXe5JIZwFkzz5X1SXU'
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
      VCR.use_cassette('create_subscription') do
        subscription = subject.create(customer_id, card_token,
          valid_subscription)
        expect(subscription).to include :id
      end
    end
  end

  describe '#list' do
    it do
      VCR.use_cassette('list_subscriptions') do
        subscription = subject.list(customer_id, card_token)[0]
        expect(subscription).to include :status
      end
    end
  end

  describe '#retrieve' do
    it do
      VCR.use_cassette('retrieve_subscription') do
        id = 'e42ac501-5538-461e-80a6-e59ef3884afc'
        subscription = subject.retrieve(id)
        expect(subscription).to include :status
      end
    end
  end

  describe '#list_payments' do
    it do
      VCR.use_cassette('list_subscription_payments') do
        id = 'e42ac501-5538-461e-80a6-e59ef3884afc'
        subscription = subject.list_payments(id)[0]
        expect(subscription).to include :status
      end
    end
  end

  describe '#delete' do
    it do
      VCR.use_cassette('delete_subscription') do
        id = 'b7ecd9fc-162a-44a8-8470-0b94cc61eafb'
        subscription = subject.delete(id)
        expect(subscription).to include :status
      end
    end
  end
end
