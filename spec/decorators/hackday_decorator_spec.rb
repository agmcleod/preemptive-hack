require 'rails_helper'

describe HackdayDecorator do
  describe '#has_hardware?' do
    it 'should have hardware with id 1' do
      hackday = Hackday.new
      hackday.hardwares_hackdays.build(hardware_id: 1)
      expect(hackday.has_hardware?(Hardware.new(id: 1))).to be_truthy
    end
  end

  describe '#hash_hardware_id?' do
    before do
      @hackday = Hackday.new
      @hackday.hardwares_hackdays.build(hardware_id: 1)
    end

    it 'should have id 1' do
      expect(@hackday.has_hardware_id?(1)).to be_truthy
    end


    it 'should not have id 5' do
      expect(@hackday.has_hardware_id?(5)).to be_falsey
    end
  end

  describe '#sync_hardware' do
    before do
      @hackday = Hackday.new(id: 1)
      @hackday.stub :save!
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

    context 'existing hardware, no longer checked' do
      before do
        @hackday.hardwares_hackdays.build(hardware_id: 5)
        @hackday.hardwares_hackdays.build(hardware_id: 6)
        @hackday.hardwares_hackdays.build(hardware_id: 6)
        @hackday.sync_hardware({
          1 => '1',
          2 => '1',
          3 => '1'
        })
      end
      it 'the existing 5 should not be in the collection' do
        expect(@hackday.hardwares_hackdays.map(&:hardware_id)).to_not include(5)
      end

      it 'the existing 6 should not be in the collection' do
        expect(@hackday.hardwares_hackdays.map(&:hardware_id)).to_not include(6)
      end

      it 'the existing 7 should not be in the collection' do
        expect(@hackday.hardwares_hackdays.map(&:hardware_id)).to_not include(7)
      end
    end
  end
end
