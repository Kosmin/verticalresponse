# -*- encoding: utf-8 -*-
# stub: verticalresponse 0.1.8 ruby lib

Gem::Specification.new do |s|
  s.name = "verticalresponse"
  s.version = "0.1.8"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Cosmin Atanasiu", "Sridhar  Devulkar", "Esteban  Munoz"]
  s.date = "2014-06-18"
  s.description = "Gem used to connect to VerticalResponse.com's API "
  s.email = ["innorogue@gmail.com", "sdevulkar@verticalresponse.com", "emunoz@verticalresponse.com"]
  s.extra_rdoc_files = ["LICENSE", "README.md"]
  s.files = ["LICENSE", "README.md", "lib/verticalresponse.rb", "lib/verticalresponse/api/client.rb", "lib/verticalresponse/api/contact.rb", "lib/verticalresponse/api/custom_field.rb", "lib/verticalresponse/api/email.rb", "lib/verticalresponse/api/error.rb", "lib/verticalresponse/api/list.rb", "lib/verticalresponse/api/message.rb", "lib/verticalresponse/api/oauth.rb", "lib/verticalresponse/api/resource.rb", "lib/verticalresponse/api/response.rb", "lib/verticalresponse/api/social_post.rb"]
  s.licenses = ["GPLv3"]
  s.rubygems_version = "2.4.3"
  s.summary = "Gem used to connect to VerticalResponse.com's API"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>, ["~> 1.3"])
    else
      s.add_dependency(%q<bundler>, ["~> 1.3"])
    end
  else
    s.add_dependency(%q<bundler>, ["~> 1.3"])
  end
end
