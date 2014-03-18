require 'spec_helper'

describe HackdayOrganization do
  describe '::create_test_user' do
    it 'should have a user object' do
      org = HackdayOrganization.new(name: Faker::Company.name)
      org.owners << User.first_or_create(username: 'testuser', password: 'abc123', password_confirmation: 'abc123', email: 'test@example.com')
      org.create_test_user
      expect(org.users.size).to eq(1)
    end
  end
end
