# frozen_string_literal: true
require 'spec_helper'

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
        first_name: 'Juan',
        middle_name: 'dela',
        last_name: 'Cruz',
        contact: {
          phone: '+63(2)1234567890',
          email: 'paymayabuyer1@gmail.com'
        },
        shipping_address: {
          line1: '9F Robinsons Cybergate 3',
          line2: 'Pioneer Street',
          city: 'Mandaluyong City',
          state: 'Metro Manila',
          zip_code: '12345',
          country_code: 'PH'
        },
        billing_address: {
          line1: '9F Robinsons Cybergate 3',
          line2: 'Pioneer Street',
          city: 'Mandaluyong City',
          state: 'Metro Manila',
          zip_code: '12345',
          country_code: 'PH'
        },
        ip_address: '125.60.148.241'
      },
      redirect_url: {
        success: 'http://www.askthemaya.com/',
        failure: 'http://www.askthemaya.com/failure?id=6319921',
        cancel: 'http://www.askthemaya.com/cancel?id=6319921'
      },
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
          total_amount: {
            value: '4863.30',
            details: {
              discount: '300.00',
              subtotal: '5163.30'
            }
          }
        }
      ],
      request_reference_number: '000141386713',
      metadata: {}
    }
  end

  before :example do
    allow(Paymaya).to receive(:config).and_return(
      double(
        base_url: base_url,
        checkout_secret_key: secret_key,
        checkout_public_key: public_key
      )
    )
  end

  describe '#create' do
    it do
      VCR.use_cassette('create_checkout') do
        checkout = subject.create(valid_checkout)
        expect(checkout).to include :checkout_id
        expect(checkout).to include :redirect_url
      end
    end
  end

  describe '#retrieve' do
    it do
      VCR.use_cassette('retrieve_checkout') do
        id = 'f739d287-7cbf-44eb-8a59-0e64562521b2'
        checkout = subject.retrieve(id)
        expect(checkout).to include :id
      end
    end
  end
end
