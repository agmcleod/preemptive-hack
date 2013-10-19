require 'spec_helper'

describe Hardware do
  describe '::for_hackday_organization' do
    before do
      @hackday_organization = FactoryGirl.create :hackday_organization
    end
    context 'none for org' do
      before do
        3.times.each { FactoryGirl.create :hardware }
      end

      it 'should return 3' do
        Hardware.for_hackday_organization(@hackday_organization.id).size.should eq(3)
      end
    end

    context '2 for org' do
      before do
        3.times.each { FactoryGirl.create :hardware }
        2.times.each { FactoryGirl.create :hardware, hackday_organization: @hackday_organization }
      end

      it 'should return 3' do
        Hardware.for_hackday_organization(@hackday_organization.id).size.should eq(5)
      end
    end
  end
end
