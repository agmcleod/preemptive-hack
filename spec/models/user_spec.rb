require 'spec_helper'

describe User do
  describe '::guest_account' do
    it 'should get a user with the guestaccount as the user name' do
      u = User.guest_account
      expect(u.username).to eq('guestaccount')
    end
  end
end
