require 'spec_helper'

describe Paymaya::PaymentVault::Payment do
  let(:public_key) { 'pk-EpTu7LXv8mwuONutYflskyYdqRSx1Ing9K3V3JtBRqB' }
  let(:secret_key) { 'sk-GgVT0xX7YJcWBauR4UqnMkyFt8GpksixEUaV7qWnDJc' }

  let(:base_url) { 'https://pg-sandbox.paymaya.com' }

  let(:valid_payment) do
    {
      payment_token_id: 'ikBrcKmHEBsKQM99moUmyr48TqWj8q1eB6WXCxSFwTNOCURTvCLWxbYx4shMXMZEh2Vg5D3vTY1sqUCOsmAyPqMir6GUqolDEdrJSiaovsZONvUufqUgIa2SRH6bL4k9G3OMNho2S86E5OeSHtNFnduqnzQInTGU',
      total_amount: {
        amount: 100,
        currency: 'PHP'
      },
      buyer: {
        first_name: 'Ysa',
        middle_name: 'Cruz',
        last_name: 'Santos',
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
        }
      }
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
      VCR.use_cassette('create_payment') do
        payment = subject.create(valid_payment)
        expect(payment).to include :id
      end
    end
  end

  describe '#retrieve' do
    it do
      VCR.use_cassette('retrieve_payment') do
        id = '4873e908-0a78-416b-b2f4-432080e6ee85'
        payment = subject.retrieve(id)
        expect(payment).to include :status
      end
    end
  end

  describe '#void' do
    it do
      VCR.use_cassette('void_payment') do
        id = '4873e908-0a78-416b-b2f4-432080e6ee85'
        reason = 'Void reason'
        payment = subject.void(id, reason)
        expect(payment).to include :status
      end
    end
  end

  describe '#refund' do
    it do
      VCR.use_cassette('refund_payment') do
        payment = 'a4fb5b17-9d84-4b8e-ae9f-d61dc95f3f8b'
        refund = subject.refund(payment, {
          amount: 10,
          currency: 'PHP'
        }, 'Test refund')
        expect(refund).to include :status
      end
    end
  end

  describe '#list_refunds' do
    it do
      VCR.use_cassette('list_refunds') do
        payment = 'a4fb5b17-9d84-4b8e-ae9f-d61dc95f3f8b'
        refund = subject.list_refunds(payment)[0]
        expect(refund).to include :status
      end
    end
  end

  describe '#retrieve_refund' do
    it do
      VCR.use_cassette('retrieve_refund') do
        payment = 'a4fb5b17-9d84-4b8e-ae9f-d61dc95f3f8b'
        id = 'a871f909-e169-49c6-8fba-772ef2102ec9'
        refund = subject.retrieve_refund(payment, id)
        expect(refund).to include :status
      end
    end
  end
end
