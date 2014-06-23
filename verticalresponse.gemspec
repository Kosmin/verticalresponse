Gem::Specification.new do |spec|
  spec.name        = 'verticalresponse'
  spec.version     = '0.1.2'
  spec.date        = '2014-06-18'
  spec.summary     = "Gem used to connect to VerticalResponse.com's API "
  spec.description = "Gem used to connect to VerticalResponse.com's API "
  spec.authors     = ["Cosmin Atanasiu", "Sridhar  Devulkar", "Esteban  Munoz"]
  spec.email       = ["innorogue@gmail.com", "emunoz@verticalresponse.com", "sdevulkar@verticalresponse.com"]
  spec.extra_rdoc_files = [
    "LICENSE",
    "README.md"
  ]
  spec.files       = %w'
    lib/client.rb
    lib/custom_field.rb
    lib/error.rb
    lib/message.rb
    lib/resource.rb
    lib/social_post.rb
    lib/contact.rb
    lib/email.rb
    lib/list.rb
    lib/oauth.rb
    lib/response.rb
    lib/verticalresponse.rb
  '
  spec.require_paths = ["lib"]
  spec.license     = 'GPLv3'
end
