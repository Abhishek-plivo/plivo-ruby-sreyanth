# Plivo Ruby Helper SDK

**Note**: `Bleeding edge: Use with caution`

## Description
Plivo Ruby helper library to access PlivoCloud API and generate Plivo XML

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'plivo'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install plivo

## Authentication:

To use the Ruby SDK with a single client, create an api object with `api = RestClient.new`, and all API calls will use this global api client by default.
We recommend that you store your credentials in the `PLIVO_AUTH_ID` and the `PLIVO_AUTH_TOKEN` environment variables, so as to avoid the possibility of accidentally committing them to source control. If you do this, you can initialise the client with no arguments and it will automatically fetch them from the environment variables:

```ruby
api = RestClient.new;
```

Alternatively, you can provide these to `RestClient`'s constructor yourself:

```ruby
api = RestClient.new("YOU_AUTH_ID", "YOUR_AUTH_TOKEN");
```

If you are making several requests to Plivo's API, please re-use the same client instance for maximum efficiency.

## The Basics

To send a message:

```ruby
api = RestClient.new
api.messages.create('14153336666', ['14156667777', 123_123_123_123], 'Test Message')
```

To make a call

```ruby
api = RestClient.new
api.calls.create('321321321321', ['123123123112'], 'http://s3.amazonaws.com/static.plivo.com/answer.xml')
```

To list all objects of any resource, simply use the response object's `objects` as an iterable:

```ruby
api = RestClient.new
response = api.messages.list
response[:objects].each do |message|
   puts message.id
end
```

To generate PlivoXML:

```ruby
response = Response.new
response.addSpeak('Hello World, from Plivo!')
xml = PlivoXML.new(response)
puts xml.to_xml
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).