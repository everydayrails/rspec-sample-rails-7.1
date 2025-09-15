RSpec::Matchers.define :require_login do |expected|
  match do |actual|
    actual.redirect_url == route_for(:sign_in)
  end

  failure_message do |actual|
    "Expected redirected URL \"#{actual.redirect_url}\" to be " +
    "\"#{route_for(:sign_in)}\""
  end

  failure_message_when_negated do |actual|
    "Expected redirected URL \"#{actual.redirect_url}\" to not be " +
    "\"#{route_for(:sign_in)}\""
  end
end

RSpec::Matchers.alias_matcher :require_authentication, :require_login
