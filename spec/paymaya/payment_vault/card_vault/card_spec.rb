require 'spec_helper'
require 'awrence'

describe Paymaya::PaymentVault::CardVault::Card do
  let(:public_key) { 'pk-8rOz4MQKRxd5OLKBPcR6FIUx4Kay71kB3UrBFDaH172' }
  let(:secret_key) { 'sk-VrEDVetYZ6f4R1w4g0npwLzeBXtksd1smJ5lqk9Yh4y' }

  let(:base_url) { 'https://pg-sandbox.paymaya.com' }

  let(:valid_card) do
    {
      "paymentTokenId": "crd_6LmZsA3V2Cypjp4242",
      "isDefault": true,
      "redirectUrl": {
        "success": "http://shop.server.com/success?id=123",
        "failure": "http://shop.server.com/failure?id=123",
        "cancel": "http://shop.server.com/cancel?id=123"
      }
    }.to_snake_keys
  end

  let(:valid_card_update) do
    {
      isDefault: false
    }
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
      VCR.use_cassette('create_card') do
        card = subject.create(valid_card)
        expect(card).to include :id
      end
    end
  end

  describe '#list' do
    it do
      VCR.use_cassette('list_cards') do
        id = ''
        card = subject.list(id)
        expect(card).to include :state
      end
    end
  end

  describe '#retrieve' do
    it do
      VCR.use_cassette('retrieve_card') do
        id = ''
        card = subject.retrieve(id)
        expect(card).to include :state
      end
    end
  end

  describe '#update' do
    it do
      VCR.use_cassette('update_card') do
        id = ''
        card = subject.update(id, valid_card_update)
        expect(card).to include :state
      end
    end
  end

  describe '#delete' do
    it do
      VCR.use_cassette('delete_card') do
        id = ''
        card = subject.delete(id)
        expect(card).to include :state
      end
    end
  end
end
