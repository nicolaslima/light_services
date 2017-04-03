# LightServices

LightServices is a simple base to help build a service layer

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'light_services'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install light_services

## Usage

```ruby

# app/models/user.rb
class User

  attr_reader :errors
  attr_accessor :first_name, :last_name, :errors

  def initialize(first_name, last_name)
    @first_name = first_name
    @last_name  = last_name
    @errors     = []
  end

  def save
    puts "saving in some db..."
  end

  def add_errors(message)
    @errors.push message 
  end
end

# app/services/user_creator.rb
class UserCreator < LightServices::Service

  attributes :first_name, :last_name
  validates  :first_name, :last_name, presence: true
  execute    :create_user, if: :input_valid?, fallback: :add_error
  
  returns User do |user|
    @user = user.new @first_name, @last_name
  end

  def create_user
    @user.save
    # ... other complexity logic
  end

  def add_error
    @user.add_errors( "Opss, something it's wrong" )
  end

end

user = UserCreator.new(first_name: 'Aragorn II', last_name: 'son of Arathorn').call

```

### API doc

* **attributes**

`attributes` defines service inputs and will declares a instance variabel with the same name.
You need pass the keywords from `initialize` like:

```ruby

### hello_world_service.rb
attributes :name # declares @name 

### hello_world_controller.rb
HelloWorldService.new(name: 'Aragorn')
```

* **validates**

`validates` is from ActiveModel::Validations

* **execute**

`execute` delegates which method will be called when the `#call` is invoked.

*options*

  `if:` - validation method, you can override it or pass other method (need returns boolean value)

  `fallback:` - is invoked when the validations method isn't valid

* **returns**

declares what will be returned.
You can access `returns` through the instance variable with the same name.

`returns` accept block to initialize the returns e.g.

```ruby
#hello_world_service.rb

returns User do |user|
  @user = user.new
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/nicolaslima/light_services.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

