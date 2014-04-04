# BubbleWrap::HTTP

[![Build Status](https://travis-ci.org/rubymotion/BubbleWrap-HTTP.svg?branch=master)](https://travis-ci.org/rubymotion/BubbleWrap-HTTP)

## Installation

Add this line to your application's Gemfile:

```
gem 'bubble-wrap-http'
```

And then execute:

```
$ bundle
```

Or install it yourself as:

```
gem install bubble-wrap-http
```

## Usage

`BubbleWrap::HTTP` wraps `NSURLRequest`, `NSURLConnection` and friends to provide Ruby developers with a more familiar and easier to use API.
The API uses async calls and blocks to stay as simple as possible.

To enable it add the following require line to your `Rakefile`:
```ruby
require 'bubble-wrap-http'
```

Usage example:

```ruby
BubbleWrap::HTTP.get("https://api.github.com/users/mattetti") do |response|
  p response.body.to_str
end
```

```ruby
BubbleWrap::HTTP.get("https://api.github.com/users/mattetti", {credentials: {username: 'matt', password: 'aimonetti'}}) do |response|
  p response.body.to_str # prints the response's body
end
```

```ruby
data = {first_name: 'Matt', last_name: 'Aimonetti'}
BubbleWrap::HTTP.post("http://foo.bar.com/", {payload: data}) do |response|
  if response.ok?
    json = BW::JSON.parse(response.body.to_str)
    p json['id']
  elsif response.status_code.to_s =~ /40\d/
    App.alert("Login failed")
  else
    App.alert(response.error_message)
  end
end
```

To upload files to a server, provide a `files:` hash:

```ruby
data = {token: "some-api-token"}
avatar_data = UIImagePNGRepresentation(UIImage.imageNamed("some-image"))
avatar = { data: avatar_data, filename: "some-image.png", content_type: "image/png" }

BubbleWrap::HTTP.post("http://foo.bar.com/", {payload: data}, files: { avatar: avatar }) do |response|
  if response.ok?
    # files are uploaded
  end
end
```

A `:download_progress` option can also be passed. The expected object
would be a Proc that takes two arguments: a float representing the
amount of data currently received and another float representing the
total amount of data expected.

Connections can also be cancelled. Just keep a refrence,

```ruby
@conn = BubbleWrap::HTTP.get("https://api.github.com/users/mattetti") do |response|
  p response.body.to_str
end
```

and send the `cancel` method to it asynchronously as desired. The block will not be executed.

```ruby
@conn.cancel
```

### Gotchas

Because of how RubyMotion currently works, you sometimes need to assign objects as `@instance_variables` in order to retain their callbacks.

For example:

```ruby
class HttpClient
  def get_user(user_id, &callback)
    BubbleWrap::HTTP.get(user_url(user_id)) do |response|
      # ..
    end
  end
end
```

This class should be invoked in your code as:

```ruby
@http_client = HttpClient.new
@http_client.get_user(user_id) do |user|
  # ..
end
```

(instead of doing an instance-variable-less `HttpClient.new.get_user`)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
