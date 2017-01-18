# PayMaya Ruby SDK

The PayMaya Ruby SDK allows your Ruby/Ruby on Rails app to accept payments from your customers using any MasterCard and Visa enabled card (credit, debit, or prepaid). 

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'paymaya'
```

Then execute:

    $ bundle

## Configuration

Configure the plugin by writing an initializer:

```ruby
Paymaya.configure do |config|
  config.mode = :sandbox
  config.payment_vault_public_key = 'pk_abc123'
  config.payment_vault_secret_key = 'sk_abc123'
  config.checkout_public_key = 'pk_abc123'
  config.checkout_secret_key = 'sk_abc123'
end
```

Set `config.mode` to either `:sandbox` or `:prod` to  switch between the sandbox and prod endpoints, and the keys to the corresponding keys provided by PayMaya.

## Usage

See the [PayMaya Ruby SDK Wiki Page](https://github.com/PayMaya/paymaya-ruby-sdk/wiki) for more information regarding usage and integration.
