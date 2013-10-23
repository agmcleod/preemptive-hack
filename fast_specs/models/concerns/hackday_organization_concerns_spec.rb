require 'fast_spec_helper'
app_require 'app/models/concerns/hackday_organization_concerns'

class UsersHackdayOrganization < FromHash
  attr_accessor :user_id

  class << self
    def where(*args)
      self
    end

    def destroy_all(*args)
      self
    end
  end
end

class HackdayOrganization < FromHash
  include HackdayOrganizationConcerns

  attr_accessor :id

  class << self
    def transaction
      yield
    end
  end

  def initialize(hash = {})
    super(hash)
    @set = AssociationSet.new [], UsersHackdayOrganization
  end

  def users_hackday_organizations
    @set
  end
end

describe HackdayOrganizationConcerns do
  describe '#has_user_id?' do
    let(:hackday_organization) { HackdayOrganization.new }
    it 'should have id 1' do
      hackday_organization.users_hackday_organizations.build(user_id: 1)
      expect(hackday_organization.has_user_id?(1)).to be_true
    end

    it 'should not have id 3' do
      expect(hackday_organization.has_user_id?(3)).to be_false
    end
  end

  describe '#sync_users' do
    let(:hackday_organization) { HackdayOrganization.new(id: 1) }

    context 'no existing users' do
      it 'should have a collection of 2' do
        hackday_organization.sync_users({
          1 => '1',
          2 => '1'
        })

        expect(hackday_organization.users_hackday_organizations.size).to eq(2)
      end

      it 'the collection should receive a destroy all' do
        UsersHackdayOrganization.should_receive :destroy_all
        hackday_organization.sync_users({
          1 => '1',
          2 => '1'
        })
      end
    end

    context 'existing users' do
      it 'should return only 3, not 4' do
        hackday_organization.users_hackday_organizations.build(user_id: 1)
        hackday_organization.sync_users({
          1 => '1',
          2 => '1',
          3 => '1'
        })
        expect(hackday_organization.users_hackday_organizations.size).to eq(3)
      end
    end
  end
end
