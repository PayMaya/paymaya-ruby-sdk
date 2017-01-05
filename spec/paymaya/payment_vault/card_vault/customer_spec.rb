# frozen_string_literal: true
require 'spec_helper'

describe Paymaya::PaymentVault::CardVault::Customer do
  let(:public_key) { 'pk-Xu1VAKiNdLj3fyQ7MT4kRYAQ5Oe0RjBcbN5MfcRevSn' }
  let(:secret_key) { 'sk-dOxQfFiCZ7ImhHAsLLTVPpuVt3XBtqPzbcpeJa3TBJv' }

  let(:base_url) { 'https://pg-sandbox.paymaya.com' }

  let(:valid_customer) do
    {
      first_name: 'Ysabelle',
      middle_name: 'Cruz',
      last_name: 'Santos',
      birthday: '1987-01-01',
      sex: 'F',
      contact: {
        phone: '+63(2)1234567890',
        email: 'ysadcsantos@gmail.com'
      },
      billing_address: {
        line1: '9F Robinsons Cybergate 3',
        line2: 'Pioneer Street',
        city: 'Mandaluyong City',
        state: 'Metro Manila',
        zip_code: '12345',
        country_code: 'PH'
      },
      metadata: {}
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
      VCR.use_cassette('create_customer') do
        customer = subject.create(valid_customer)
        expect(customer).to include :id
      end
    end
  end

  describe '#retrieve' do
    it do
      VCR.use_cassette('retrieve_customer') do
        id = 'c52866a8-c30f-4233-afd4-473b069ac751'
        customer = subject.retrieve(id)
        expect(customer).to include :first_name
      end
    end
  end

  describe '#update' do
    it do
      VCR.use_cassette('update_customer') do
        id = 'c52866a8-c30f-4233-afd4-473b069ac751'
        customer = subject.update(id, valid_customer)
        expect(customer).to include :first_name
      end
    end
  end

  describe '#delete' do
    it do
      VCR.use_cassette('delete_customer') do
        id = 'c52866a8-c30f-4233-afd4-473b069ac751'
        customer = subject.delete(id)
        expect(customer).to include :first_name
      end
    end
  end
end
