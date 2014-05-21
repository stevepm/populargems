module OmniauthMacros
  def mock_auth_hash(username = 'stevepm')
    # The mock_auth configuration allows you to set per-provider (or default)
    # authentication hashes to return during integration testing.
    OmniAuth.config.mock_auth[:github] = {'provider' => 'github',
                                          'uid' => '12345',
                                          'extra' =>
                                            {'raw_info' =>
                                               {'login' => username}
                                            }
    }
  end
end