require 'spec_helper'
require 'awrence'

describe Paymaya::PaymentVault::CardVault::Customer do
  let(:public_key) { 'pk-8rOz4MQKRxd5OLKBPcR6FIUx4Kay71kB3UrBFDaH172' }
  let(:secret_key) { 'sk-VrEDVetYZ6f4R1w4g0npwLzeBXtksd1smJ5lqk9Yh4y' }

  let(:base_url) { 'https://pg-sandbox.paymaya.com' }

  let(:valid_customer) do
    {
      'firstName': 'Ysabelle',
      'middleName': 'Cruz',
      'lastName': 'Santos',
      'birthday': '1987-0101',
      'sex': 'F',
      'contact': {
        'phone': '+63(2)1234567890',
        'email': 'ysadcsantos@gmail.com'
      },
      'billingAddress': {
        'line1': '9F Robinsons Cybergate 3',
        'line2': 'Pioneer Street',
        'city': 'Mandaluyong City',
        'state': 'Metro Manila',
        'zipCode': '12345',
        'countryCode': 'PH'
      },
      'metadata': {}
    }.to_snake_keys
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
        id = ''
        customer = subject.retrieve(id)
        expect(customer).to include :first_name
      end
    end
  end

  describe '#update' do
    it do
      VCR.use_cassette('update_customer') do
        id = ''
        customer = subject.update(id, valid_customer)
        expect(customer).to include :first_name
      end
    end
  end

  describe '#delete' do
    it do
      VCR.use_cassette('delete_customer') do
        id = ''
        customer = subject.delete(id)
        expect(customer).to include :first_name
      end
    end
  end
end
