module CreateUserHelper
  def mock_user(username = 'stevepm')
    User.create(provider: 'github', uid: 1234, name: username)
  end
end