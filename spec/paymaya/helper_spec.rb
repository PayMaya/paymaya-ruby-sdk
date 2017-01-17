# frozen_string_literal: true
require 'spec_helper'

describe Paymaya::Helper do
  describe '#payment_facilitator' do
    let(:submerchant_id) { 'submerchant-id' }
    let(:submerchant_name) { 'submerchant-name' }
    let(:submerchant_city) { 'submerchant-city' }
    let(:submerchant_pos_country) { '604' }
    let(:submerchant_country_code) { 'USA' }
    let(:submerchant_state_code) { 'UT' }

    it 'generates basic payment facilitator hash' do
      pf = subject.payment_facilitator(
        submerchant_id: submerchant_id,
        submerchant_name: submerchant_name,
        submerchant_city: submerchant_city,
        submerchant_pos_country: submerchant_pos_country,
        submerchant_country_code: submerchant_country_code,
        submerchant_state_code: submerchant_state_code
      )
      expect(pf[:smi]).to eq submerchant_id
      expect(pf[:smn]).to eq submerchant_name
      expect(pf[:mci]).to eq submerchant_city
      expect(pf[:mpc]).to eq submerchant_pos_country
      expect(pf[:mco]).to eq submerchant_country_code
      expect(pf[:mst]).to eq submerchant_state_code
    end
  end

  describe '#snakify' do
    it 'sets hash members of an array to snake case' do
      input = ['a', {
        'aRandomWord' => 'someRandomPhrase',
        'anotherArray' => [
          {
            'anotherHash' => 'b'
          }
        ]
      }, 'b']
      snakified = subject.snakify(input)
      expect(snakified[1]).to include :a_random_word
      expect(snakified[1]).to include :another_array
      expect(snakified[1][:another_array][0]).to include :another_hash
    end
  end

  describe '#camelify' do
    it 'sets hash members of an array to camelback case' do
      input = ['a', {
        'a_random_word' => 'someRandomPhrase',
        'another_array' => [
          {
            'another_hash' => 'b'
          }
        ]
      }, 'b']
      camelified = subject.camelify(input)
      expect(camelified[1]).to include 'aRandomWord'
      expect(camelified[1]).to include 'anotherArray'
      expect(camelified[1]['anotherArray'][0]).to include 'anotherHash'
    end
  end

  describe 'auth header functions' do
    before :example do
      allow(Paymaya).to receive(:config).and_return(config)
    end

    describe '#payment_vault_public_auth_headers' do
      let(:config) do
        double(payment_vault_public_key: 'payment_vault_public_key')
      end
      it 'returns a hash with authorization and content_type for headers' do
        headers = subject.payment_vault_public_auth_headers
        expect(headers).to include :authorization
        expect(headers).to include :content_type
        expect(headers[:authorization])
          .to eq 'Basic cGF5bWVudF92YXVsdF9wdWJsaWNfa2V5Og=='
      end
    end

    describe '#payment_vault_secret_auth_headers' do
      let(:config) do
        double(payment_vault_secret_key: 'payment_vault_secret_key')
      end
      it 'returns a hash with authorization and content_type for headers' do
        headers = subject.payment_vault_secret_auth_headers
        expect(headers).to include :authorization
        expect(headers).to include :content_type
        expect(headers[:authorization])
          .to eq 'Basic cGF5bWVudF92YXVsdF9zZWNyZXRfa2V5Og=='
      end
    end

    describe '#checkout_public_auth_headers' do
      let(:config) { double(checkout_public_key: 'checkout_public_key') }
      it 'returns a hash with authorization and content_type for headers' do
        headers = subject.checkout_public_auth_headers
        expect(headers).to include :authorization
        expect(headers).to include :content_type
        expect(headers[:authorization])
          .to eq 'Basic Y2hlY2tvdXRfcHVibGljX2tleTo='
      end
    end

    describe '#checkout_secret_auth_headers' do
      let(:config) { double(checkout_secret_key: 'checkout_secret_key') }
      it 'returns a hash with authorization and content_type for headers' do
        headers = subject.checkout_secret_auth_headers
        expect(headers).to include :authorization
        expect(headers).to include :content_type
        expect(headers[:authorization])
          .to eq 'Basic Y2hlY2tvdXRfc2VjcmV0X2tleTo='
      end
    end
  end
end
