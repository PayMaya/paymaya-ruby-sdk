# frozen_string_literal: true
require 'spec_helper'

describe Paymaya::PaymentVault::CardVault::Card do
  let(:public_key) { 'pk-EpTu7LXv8mwuONutYflskyYdqRSx1Ing9K3V3JtBRqB' }
  let(:secret_key) { 'sk-GgVT0xX7YJcWBauR4UqnMkyFt8GpksixEUaV7qWnDJc' }

  let(:base_url) { 'https://pg-sandbox.paymaya.com' }

  let(:valid_card) do
    {
      payment_token_id: 'wdi6mkRvsaLNTiTOoMJD3GLUrdC0SdBvr7e6LbJvjxU2gjdr5k9Gynj0GQN7f9fofsDBlqy0Zzq6u4Vwhfd8hug0dCQo3NSb3RDV2GndnhmSEkKoY4eoAlxYaZUtJ4mFObMGGHxPmTaXZC9rBuPXe5JIZwFkzz5X1SXU',
      is_default: true,
      redirect_url: {
        success: 'http://shop.server.com/success?id=123',
        failure: 'http://shop.server.com/failure?id=123',
        cancel: 'http://shop.server.com/cancel?id=123'
      }
    }
  end

  let(:valid_card_update) do
    {
      is_default: true
    }
  end

  let(:customer_id) { '5f39f980-225f-4805-b61f-50e84ce3fcdf' }
  let(:card_id) { 'wdi6mkRvsaLNTiTOoMJD3GLUrdC0SdBvr7e6LbJvjxU2gjdr5k9Gynj0GQN7f9fofsDBlqy0Zzq6u4Vwhfd8hug0dCQo3NSb3RDV2GndnhmSEkKoY4eoAlxYaZUtJ4mFObMGGHxPmTaXZC9rBuPXe5JIZwFkzz5X1SXU' }

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
      VCR.use_cassette('create_card') do
        card = subject.create(customer_id, valid_card)
        expect(card).to include :id
      end
    end
  end

  describe '#list' do
    it do
      VCR.use_cassette('list_cards') do
        card = subject.list(customer_id)[0]
        expect(card).to include :state
      end
    end
  end

  describe '#retrieve' do
    it do
      VCR.use_cassette('retrieve_card') do
        card = subject.retrieve(customer_id, card_id)
        expect(card).to include :state
      end
    end
  end

  describe '#update' do
    it do
      VCR.use_cassette('update_card') do
        card = subject.update(customer_id, card_id, valid_card_update)
        expect(card).to include :state
      end
    end
  end

  describe '#delete' do
    it do
      VCR.use_cassette('delete_card') do
        id = 'SEoXZtBtNX1AMgUDeJWlnzOaqH6ofjNYAAyRuD6osoBKkkPgT1axov0hkoKWoYayojFFGt0ZtycD8ALz9EU1sSvD7RMo547NRXnEMdDOw91RDuWeaU1ZXpo7oflKt8B8ae4rgNclThq65E7FixsDCH2C8N7skG1ztUw'
        card = subject.delete(customer_id, id)
        expect(card).to include :state
      end
    end
  end
end
