# ============================================================
# We want to access instances of OAuth with OOP, so we'll include
# some wrappers that let us use do the following:
#   client = OAuth.new(access_token)
#   client.lists
#   client.contacts
#
# Please note, using static libraries isn't "object-oriented".
# Using instances is. The client in the example above is an
# example of an instance. This whole gem uses libraries
# instead of instances which is very bad.
#
# TODO: this whole gem should be more object-oriented, but for
# now this should work
# ============================================================

Gem::Specification.new do |spec|
  spec.name        = 'verticalresponse'
  spec.version     = '0.1.5'
  spec.date        = '2014-06-18'
  spec.summary     = "Gem used to connect to VerticalResponse.com's API "
  spec.description = "Gem used to connect to VerticalResponse.com's API "
  spec.authors     = ["Cosmin Atanasiu", "Sridhar  Devulkar", "Esteban  Munoz"]
  spec.email       = ["innorogue@gmail.com", "sdevulkar@verticalresponse.com", "emunoz@verticalresponse.com"]
  spec.extra_rdoc_files = [
    "LICENSE",
    "README.md"
  ]
  spec.files       = %w'
    lib/verticalresponse.rb
    lib/verticalresponse/api/oauth.rb
    lib/verticalresponse/api/client.rb
    lib/verticalresponse/api/custom_field.rb
    lib/verticalresponse/api/error.rb
    lib/verticalresponse/api/message.rb
    lib/verticalresponse/api/resource.rb
    lib/verticalresponse/api/social_post.rb
    lib/verticalresponse/api/contact.rb
    lib/verticalresponse/api/email.rb
    lib/verticalresponse/api/list.rb
    lib/verticalresponse/api/response.rb
  '

  spec.add_development_dependency "bundler", "~> 1.3"

  spec.require_paths = ["lib"]
  spec.license     = 'GPLv3'
end
