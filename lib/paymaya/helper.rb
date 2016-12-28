require 'awrence'
require 'plissken'

module Paymaya
  module Helper
    def self.payment_facilitator(submerchant_id, submerchant_name,
        submerchant_city, submerchant_pos_country, submerchant_country_code,
        submerchant_state_code = nil)
      pf = {
        smi: submerchant_id,
        smn: submerchant_name,
        mci: submerchant_city,
        mpc: submerchant_pos_country,
        mco: submerchant_country_code
      }
      pf[:mst] = submerchant_state_code unless submerchant_state_code.nil?
      pf
    end

    def self.snakify(input)
      if input.is_a? Array
        return input.map do |elem|
          snakify(elem)
        end
      end
      if input.is_a? Hash
        hash = input.to_snake_keys
        hash.each do |k, v|
          hash[k] = snakify(v) if v.is_a? Array
        end
        return hash
      end
      input
    end

    def self.camelify(input)
      if input.is_a? Array
        return input.map do |elem|
          camelify(elem)
        end
      end
      if input.is_a? Hash
        hash = input.to_camelback_keys
        hash.each do |k, v|
          hash[k] = camelify(v) if v.is_a? Array
        end
        return hash
      end
      input
    end
  end
end
