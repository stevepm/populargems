module LogInHelper
  def log_in
    visit '/'
    mock_auth_hash
    click_link 'Sign in with Github'
  end
end