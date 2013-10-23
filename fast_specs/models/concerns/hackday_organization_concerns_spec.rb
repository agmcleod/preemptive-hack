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

end
