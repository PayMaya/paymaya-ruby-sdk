require 'spec_helper'
require 'awrence'

describe Paymaya::Checkout::Checkout do
  let(:public_key) { 'pk-8rOz4MQKRxd5OLKBPcR6FIUx4Kay71kB3UrBFDaH172' }
  let(:secret_key) { 'sk-VrEDVetYZ6f4R1w4g0npwLzeBXtksd1smJ5lqk9Yh4y' }

  let(:base_url) { 'https://pg-sandbox.paymaya.com' }

  let(:valid_checkout) do
    {
      total_amount: {
        currency: 'PHP',
        value: '1234.56'
      },
      buyer: {
        firstName: 'Juan',
        middleName: 'dela',
        lastName: 'Cruz',
        contact: {
          phone: '+63(2)1234567890',
          email: 'paymayabuyer1@gmail.com'
        }.to_snake_keys,
        shippingAddress: {
          line1: '9F Robinsons Cybergate 3',
          line2: 'Pioneer Street',
          city: 'Mandaluyong City',
          state: 'Metro Manila',
          zipCode: '12345',
          countryCode: 'PH'
        }.to_snake_keys,
        billingAddress: {
          line1: '9F Robinsons Cybergate 3',
          line2: 'Pioneer Street',
          city: 'Mandaluyong City',
          state: 'Metro Manila',
          zipCode: '12345',
          countryCode: 'PH'
        }.to_snake_keys,
        ipAddress: '125.60.148.241'
      }.to_snake_keys,
      redirectUrl: {
        success: 'http://www.askthemaya.com/',
        failure: 'http://www.askthemaya.com/failure?id=6319921',
        cancel: 'http://www.askthemaya.com/cancel?id=6319921'
      }.to_snake_keys,
      items: [
        {
          name: 'Canvas Slip Ons',
          code: 'CVG-096732',
          description: 'Shoes',
          quantity: '3',
          amount: {
            value: '1621.10',
            details: {
              discount: '100.00',
              subtotal: '1721.10'
            }
          },
          totalAmount: {
            value: '4863.30',
            details: {
              discount: '300.00',
              subtotal: '5163.30'
            }
          }
        }.to_snake_keys
      ],
      requestReferenceNumber: '000141386713',
      metadata: {}
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

  describe '#initiate' do
    it do
      VCR.use_cassette('initiate_checkout') do
        checkout = subject.initiate(valid_checkout)
        expect(checkout).to include 'checkoutId'
        expect(checkout).to include 'redirectUrl'
      end
    end
  end

  describe '#retrieve' do
    it do
      VCR.use_cassette('retrieve_checkout') do
        id = 'f739d287-7cbf-44eb-8a59-0e64562521b2'
        checkout = subject.retrieve(id)
        expect(checkout).to include 'id'
      end
    end
  end
end
