require 'fast_spec_helper'
app_require 'app/models/concerns/hackday_concerns'

class Hackday < FromHash
  include HackdayConcerns

  attr_accessor :id

  class << self
    def transaction
      yield
    end
  end

  def initialize(hash = {})
    super(hash)
    @set = AssociationSet.new [], HardwaresHackdays
  end

  def hardwares_hackdays
    @set
  end
end

class Hardware < FromHash
  attr_accessor :id
end

class HardwaresHackdays < FromHash
  attr_accessor :hardware_id

  class << self
    def where(*args)
      self
    end

    def destroy_all(*args)
      self
    end
  end
end

describe HackdayConcerns do
  describe '#has_hardware?' do
    let(:hackday) { Hackday.new }
    it 'should have hardware with id 1' do
      hackday.hardwares_hackdays.build(hardware_id: 1)
      expect(hackday.has_hardware?(Hardware.new(id: 1))).to be_true
    end
  end

  describe '#hash_hardware_id?' do
    before do
      @hackday = Hackday.new
      @hackday.hardwares_hackdays.build(hardware_id: 1)
    end

    it 'should have id 1' do
      expect(@hackday.has_hardware_id?(1)).to be_true
    end


    it 'should not have id 5' do
      expect(@hackday.has_hardware_id?(5)).to be_false
    end
  end

  describe '#sync_hardware' do
    before do
      @hackday = Hackday.new(id: 1)
    end

    context 'no existing hardware' do
      it 'should have a collection of 3' do
        @hackday.sync_hardware({
          1 => '1',
          2 => '1',
          3 => '1'
        })

        expect(@hackday.hardwares_hackdays.size).to eq(3)
      end

      it 'hardware hackdays should receive a destroy' do
        HardwaresHackdays.should_receive :destroy_all
        @hackday.sync_hardware({
          1 => '1',
          2 => '1',
          3 => '1'
        })
      end
    end

    context 'existing hardware' do
      it 'should return only 3, not 4' do
        @hackday.hardwares_hackdays.build(hardware_id: 1)
        @hackday.sync_hardware({
          1 => '1',
          2 => '1',
          3 => '1'
        })
        expect(@hackday.hardwares_hackdays.size).to eq(3)
      end
    end
  end
end
