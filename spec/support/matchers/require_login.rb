RSpec::Matchers.define :require_login do |expected|
  match do |actual|
    actual.redirect_url == route_for(:sign_in)
  end
end
