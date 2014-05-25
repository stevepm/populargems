module LogInHelper
  def log_in(username = 'stevepm', uid = rand(99999).to_s)
    visit '/'
    mock_auth_hash(username, uid)
    click_link 'Sign in with Github'
  end
end