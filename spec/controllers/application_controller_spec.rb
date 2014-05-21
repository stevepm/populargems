require 'spec_helper'

describe ApplicationController do
  include Capybara::DSL
  before do
    @user = User.create(provider: 'github', uid: 1234, name: 'stevepm')
  end

  describe 'current_user' do
    it 'returns the user if they are logged in' do
      controller.log_in(@user)
      expect(controller.current_user).to eq(@user)
    end

    it 'returns nil if user is not logged in' do
      expect(controller.current_user).to eq(nil)
    end
  end

  describe 'logged_in?' do
    it 'returns false if the id is not set in the session' do
      expect(controller.logged_in?).to eq(false)
    end

    it 'returns true if the id is set in the session' do
      session[:user_id] = 123
      expect(controller.logged_in?).to eq(true)
    end
  end

  describe 'log_in' do
    it 'sets id in the session' do
      controller.log_in(@user)

      expect(session[:user_id]).to eq(@user.id)
    end
  end
end