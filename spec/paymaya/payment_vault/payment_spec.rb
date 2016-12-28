require 'spec_helper'
require 'awrence'

describe Paymaya::PaymentVault::Payment do
  let(:public_key) { 'pk-8rOz4MQKRxd5OLKBPcR6FIUx4Kay71kB3UrBFDaH172' }
  let(:secret_key) { 'sk-VrEDVetYZ6f4R1w4g0npwLzeBXtksd1smJ5lqk9Yh4y' }

  let(:base_url) { 'https://pg-sandbox.paymaya.com' }

  let(:valid_payment) do
    {
      paymentTokenId: '68aKLAN64CXK7XWDA1HwSE6COo',
      totalAmount: {
        amount: 100,
        currency: 'PHP'
      },
      buyer: {
        firstName: 'Ysa',
        middleName: 'Cruz',
        lastName: 'Santos',
        contact: {
          phone: '+63(2)1234567890',
          email: 'ysadcsantos@gmail.com'
        },
        billingAddress: {
          line1: '9F Robinsons Cybergate 3',
          line2: 'Pioneer Street',
          city: 'Mandaluyong City',
          state: 'Metro Manila',
          zipCode: '12345',
          countryCode: 'PH'
        }
      }
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
      VCR.use_cassette('create_payment') do
        payment = subject.create(valid_payment)
        expect(payment).to include :id
      end
    end
  end

  describe '#retrieve' do
    it do
      VCR.use_cassette('retrieve_payment') do
        id = ''
        payment = subject.retrieve(id)
        expect(payment).to include :status
      end
    end
  end

  describe '#void' do
    it do
      VCR.use_cassette('void_payment') do
        id = ''
        payment = subject.void(id)
        expect(payment).to include :status
      end
    end
  end

  describe '#refund' do
    it do
      VCR.use_cassette('refund_payment') do
        id = ''
        payment = subject.refund(id)
        expect(payment).to include :status
      end
    end
  end

  describe '#retrieve_refunds' do
    it do
      VCR.use_cassette('retrieve_refunds') do
        id = ''
        payment = subject.retrieve_refunds(id)[0]
        expect(payment).to include :status
      end
    end
  end

  describe '#retrieve_refund' do
    it do
      VCR.use_cassette('retrieve_refund') do
        id = ''
        payment = subject.retrieve_refunds(id)
        expect(payment).to include :status
      end
    end
  end
end
