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
      pf = subject.payment_facilitator(submerchant_id, submerchant_name,
        submerchant_city, submerchant_pos_country, submerchant_country_code,
        submerchant_state_code)
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
end
