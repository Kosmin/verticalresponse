VerticalResponse
================

Gem used to make it easier to connect to VerticalResponse.com's API

Based on https://github.com/VerticalResponse/v1wrappers/

90% of the code is the same as the original wrappers. The point here was to put the official VerticalResponse wrappers in a gem, and to allow calling oauth_clients by object instances, identified by access tokens.

New Functionality
-----------------

Allows instantiating oauth clients by access_token, to access the VerticalResponse API in an object-oriented fashion.

```ruby
oauth_client = VerticalResponse::API::OAuth.new access_token
```

This allows us to get the lists for a verticalresponse user with
```ruby
oauth_client.lists
```

or the clients with
```ruby
oauth_client.clients
```

Requirements
----------
Ruby 1.9+ (compatible with Ruby 2.1.1)
HTTParty gem

Note: I only tested these requirements as much as I needed to (not for all functionalities), so you might encounter bugs here and there. But, if the community can make an effort to build this, I'm sure you can make an effort to test that this works for you as well, and even submit fixes wherever possible.

Contribute
----------
I only built this for what I needed, and I know it's pretty limited. Contributions are more than welcome
