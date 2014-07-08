VerticalResponse
================

Gem used to make it easier to connect to VerticalResponse.com's API

Based on https://github.com/VerticalResponse/v1wrappers/

90% of the code is the same as the original wrappers. The point here was to put the official VerticalResponse wrappers in a gem, and to allow calling oauth_clients by object instances, identified by access tokens.

New Functionality
-----------------

Allows instantiating oauth clients by access_token, to access the VerticalResponse API in an object-oriented fashion. The calls are object-oriented in the sense that you can instantate a client with its access_token. This is not possible with the original wrappers.

```ruby
client = VerticalResponse::API::OAuth.new access_token

# Get all lists
client.lists

# Get a specific list
client.find_list("<id>")

# Get contacts in a specific list
client.find_list("<id>").contacts

# Create multiple contacts in a specific list
client.find_list("<id>").create_contacts([{
    email: "some@email.com",
    first_name: "some first name",
    last_name: "some last name",
    custom: {
      field: "some custom field"
    }
  },
  {
    email: "another@email.com",
    first_name: "another first name",
    last_name: "another last name",
    custom: {
      field: "another custom field"
    }
  }
])

# Get all contacts
client.contacts

# Get all custom fields
client.custom_fields
```

And a few other calls as well. Not all wrapper methods are supported, but you're more than welcome to implement them yourself and submit pull requests.

Requirements
----------
Ruby 1.9+ (compatible with Ruby 2.1.1)

HTTParty gem

Note: I only tested these requirements as much as I needed to (not for all functionalities), so you might encounter bugs here and there. But, if the community can make an effort to build this, I'm sure you can make an effort to test that this works for you as well, and even submit fixes wherever possible.

Contribute
----------
The features of this gem were built as needed, and it is pretty limited. Contributions are more than welcome!
