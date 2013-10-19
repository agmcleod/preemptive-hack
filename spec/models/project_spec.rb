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
  end
end
