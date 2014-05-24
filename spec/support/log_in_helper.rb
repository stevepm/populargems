module LogInHelper
  def log_in(username = 'stevepm')
    visit '/'
    mock_auth_hash(username)
    click_link 'Sign in with Github'
  end
end