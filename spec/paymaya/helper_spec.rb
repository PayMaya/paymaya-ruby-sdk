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
end
