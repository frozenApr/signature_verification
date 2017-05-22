# SignatureVerification

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/signature_verification`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'signature_verification'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install signature_verification

## Usage

**create a signature:**

```ruby
signature = SignatureVerification.generate_signature(access_key: "adasd", secret_key: "asfew", kind: "financial", time: "1495418953", other_params: others)
```

The required params include access key, kind, time and the optional params lie on the kind you selected.
The kind could be: sdk accelerate financial. For financial, the other_params may be account_id, game_id; for accelerate, the other_params may be access_token.

**authenticate a signature:**

```ruby
authenticate = SignatureVerification.authenticate(access_key: "adasd", signature: "asfew", kind: "financial", time: "1495418953", other_params: others)
```

The params "secret_key" will be replaced by "signature" and the others are the same as creating a signature.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/sunbei/signature_verification. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
