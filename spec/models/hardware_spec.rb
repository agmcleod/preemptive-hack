require 'spec_helper'

describe Hardware do
  describe '::for_hackday_organization' do
    before do
      @hackday_organization = default_hackday_org
    end
    context 'none for org' do
      before do
        3.times.each { FactoryGirl.create :hardware }
      end

      it 'should return 3' do
        expect(Hardware.for_hackday_organization(@hackday_organization).size).to eq(3)
      end
    end

    context '2 for org' do
      before do
        3.times.each { FactoryGirl.create :hardware }
        2.times.each { @hackday_organization.hardwares.build(FactoryGirl.attributes_for(:hardware)) }
        @hackday_organization.save
      end

      it 'should return 3' do
        expect(Hardware.for_hackday_organization(@hackday_organization).size).to eq(5)
      end
    end
  end
end
