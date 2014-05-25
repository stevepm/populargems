module OmniauthMacros
  def mock_auth_hash(username = 'stevepm', uid = rand(99999).to_s)
    # The mock_auth configuration allows you to set per-provider (or default)
    # authentication hashes to return during integration testing.
    OmniAuth.config.mock_auth[:github] = {'provider' => 'github',
                                          'uid' => uid,
                                          'extra' =>
                                            {'raw_info' =>
                                               {'login' => username}
                                            }
    }
  end
end