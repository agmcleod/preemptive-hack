require 'spec_helper'

describe HackdayOrganization do
  describe '::create_test_user' do
    it 'should have a user object' do
      org = FactoryGirl.build :hackday_organization
      org.create_test_user
      org.users.size.should eq(1)
    end
  end
end
