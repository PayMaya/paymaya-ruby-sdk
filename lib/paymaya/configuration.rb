module Paymaya
  class Configuration
    attr_accessor :payment_vault_public_key, :payment_vault_secret_key,
      :base_url, :checkout_public_key, :checkout_secret_key
  end
end
