# Getting started with your own VerticalResponse Account
# ============================================

# Get an application key and an application secret from
# http://developers.verticalresponse.com/
@oauth = VerticalResponse::OAuth.new("consumer_key", "consumer_secret")

# Go to URL outputed by the following, authorize your account
# and copy the verification code
@oauth.request_token.authorize_url

# When implementing, the user would be redirected to a new page
# that can call the following method with the 'verification_code'
# obtained from params

@oauth.authorize_with_verifier("code")
