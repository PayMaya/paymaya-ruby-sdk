require 'spec_helper'

describe Paymaya::Checkout::Customization do
  let(:secret_key) { 'sk-VrEDVetYZ6f4R1w4g0npwLzeBXtksd1smJ5lqk9Yh4y' }

  let(:base_url) { 'https://pg-sandbox.paymaya.com' }

  let(:valid_customization) do
    {
      logo_url: 'https://cdn.paymaya.com/production/checkout_api/customization_example/yourlogo.svg',
      icon_url: 'https://cdn.paymaya.com/production/checkout_api/customization_example/youricon.ico',
      apple_touch_icon_url: 'https://cdn.paymaya.com/production/checkout_api/customization_example/youricon_ios.ico',
      custom_title: 'Checkout Page Title',
      color_scheme: '#368d5c'
    }
  end

  before :example do
    allow(Paymaya).to receive(:config).and_return(
      double(
        base_url: base_url,
        checkout_secret_key: secret_key
      )
    )
  end

  describe '#set' do
    it 'sets the customization' do
      VCR.use_cassette('set_customization') do
        set = subject.set(valid_customization)
        expect(set).to include 'logoUrl'
        expect(set).to include 'iconUrl'
        expect(set).to include 'appleTouchIconUrl'
        expect(set).to include 'customTitle'
        expect(set).to include 'colorScheme'
      end
    end
  end

  describe '#get' do
    it 'gets the customization' do
      VCR.use_cassette('get_customization') do
        customization = subject.get
        expect(customization).to include 'logoUrl'
        expect(customization).to include 'iconUrl'
        expect(customization).to include 'appleTouchIconUrl'
        expect(customization).to include 'customTitle'
        expect(customization).to include 'colorScheme'
      end
    end
  end

  describe '#remove' do
    it 'removes the customization' do
      VCR.use_cassette('remove_customization') do
        removed = subject.remove
        expect(removed['message']).to eq 'customizations removed'
      end
    end
  end
end
