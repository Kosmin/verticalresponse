VerticalResponse
================

Gem used to make it easier to connect to VerticalResponse.com's API

Based on https://github.com/VerticalResponse/v1wrappers/

90% of the code is the same as the original wrappers

New Functionality
-----------------

Allows instantiating oauth clients by access_token, to access the VerticalResponse API in an object-oriented fashion.

```ruby
oauth_client = VerticalResponse::API::OAuth.new access_token
```

This allows us to get the lists for a client with
```ruby
oauth_client.lists
```

