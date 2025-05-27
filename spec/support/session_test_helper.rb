module SessionTestHelper
  # Well, this is a bit of a hack. It seems that this helper for testing the new authentication generator
  # is only available in rails 8.1, so I copied it here :)

  def sign_in_as(user)
    Current.session = user.sessions.create!

    ActionDispatch::TestRequest
      .create
      .cookie_jar
      .tap do |cookie_jar|
        cookie_jar.signed[:session_id] = Current.session.id
        cookies[:session_id]         = cookie_jar[:session_id]
      end
  end

  def sign_out
    Current.user.sessions.destroy_all
    Current.session = nil
  end
end
