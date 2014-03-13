require 'spec_helper'

describe HackdayOrganization do
  describe '::create_test_user' do
    it 'should have a user object' do
      org = HackdayOrganization.new(name: Faker::Company.name)
      org.owners << User.guest_account
      org.create_test_user
      expect(org.users.size).to eq(1)
    end
  end
end
