# frozen_string_literal: true
require 'awrence'
require 'plissken'

module Paymaya
  module Helper
    def self.payment_facilitator(submerchant_id:, submerchant_name:,
      submerchant_city:, submerchant_pos_country:, submerchant_country_code:,
      submerchant_state_code: nil)
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
      transform(input, :snakify, :to_snake_keys)
    end

    def self.camelify(input)
      transform(input, :camelify, :to_camelback_keys)
    end

    def self.transform(input, method_name, hash_method)
      return transform_array(input, method_name) if input.is_a? Array
      return transform_hash(input, method_name, hash_method) if input.is_a? Hash
      input
    end

    def self.transform_array(input, method_name)
      input.map do |elem|
        send(method_name, elem)
      end
    end

    def self.transform_hash(input, method_name, hash_method)
      hash = input.send(hash_method)
      hash.each do |k, v|
        hash[k] = send(method_name, v) if v.is_a? Array
      end
      hash
    end

    def self.payment_vault_public_auth_headers
      auth_headers(Paymaya.config.payment_vault_public_key)
    end

    def self.payment_vault_secret_auth_headers
      auth_headers(Paymaya.config.payment_vault_secret_key)
    end

    def self.checkout_public_auth_headers
      auth_headers(Paymaya.config.checkout_public_key)
    end

    def self.checkout_secret_auth_headers
      auth_headers(Paymaya.config.checkout_secret_key)
    end

    def self.auth_headers(key)
      {
        authorization:
          "Basic #{Base64.strict_encode64(key + ':').chomp}",
        content_type: 'application/json'
      }
    end

    def self.request(method, url, params, headers)
      response = RestClient::Request.execute(
        method: method, url: url,
        headers: headers, payload: camelify(params).to_json
      )
      snakify(JSON.parse(response))
    end

    private_class_method :transform, :transform_array, :transform_hash,
      :auth_headers
  end
end
