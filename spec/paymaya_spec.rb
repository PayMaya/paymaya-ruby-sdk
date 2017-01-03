require 'spec_helper'

describe Paymaya do
  it 'has a version number' do
    expect(Paymaya::VERSION).not_to be nil
  end

  describe '#configure' do
    it 'configures base_url' do
      expect do
        Paymaya.configure do |config|
          config.base_url = 'base_url'
        end
      end.to change { subject.config.base_url }
        .to('base_url')
    end

    it 'configures secret_key' do
      expect do
        Paymaya.configure do |config|
          config.secret_key = 'secret_key'
        end
      end.to change { subject.config.secret_key }
        .to('secret_key')
    end

    it 'configures public_key' do
      expect do
        Paymaya.configure do |config|
          config.public_key = 'public_key'
        end
      end.to change { subject.config.public_key }
        .to('public_key')
    end
  end
end
