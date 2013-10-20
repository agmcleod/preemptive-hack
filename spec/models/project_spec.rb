require 'spec_helper'

describe Project do
  describe '::create_from_project' do
    before do
      @project = FactoryGirl.create :project
    end

    it 'should have the same name' do
      p = Project.create_from_project(@project.id)
      p.name.should eq(@project.name)
    end

    it 'should have the same amount of hardware' do
      hardware = FactoryGirl.create :hardware
      @project.hardwares << hardware
      @project.save
      count = @project.hardwares.size

      p = Project.create_from_project(@project.id)
      p.hardwares.size.should eq(count)
    end
  end
end
