require 'fast_spec_helper'
app_require 'app/models/concerns/hackday_concerns'

class Hackday < FromHash
  include HackdayConcerns

  def hardwares_hackdays
    [HardwareHackdays.new(hardware_id: 1), HardwareHackdays.new(hardware_id: 2)]
  end
end

describe HackdayConcerns do
  describe '#has_hardware?' do
    before do
      @hackday = Hackday.new
    end

    it 'should have hardware with id 1' do
      @hackday.has_hardware? Hardware.new(id: 1)
    end
  end

  describe '#hash_hardware_id?' do
    before do
      @hackday = Hackday.new
    end

    it 'should have id 1' do
      @hackday.has_hardware_id?(1).should be_true
    end


    it 'should not have id 5' do
      @hackday.has_hardware_id?(5).should be_false
    end
  end
end
