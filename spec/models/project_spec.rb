require 'spec_helper'

describe Project do
  describe '::create_from_project' do
    before do
      @project = FactoryGirl.build :project
      Project.any_instance.stub(reload: @project)
    end

    it 'should have the same name' do
      ProjectDecorator.stub find_or_return: @project
      p = Project.create_from_project(@project.id, nil)
      expect(p.name).to eq(@project.name)
    end

    it 'should have the same amount of hardware' do
      @project.hardwares.build(FactoryGirl.attributes_for(:hardware))
      count = @project.hardwares.length
      project = Project.create_from_project(@project, nil)
      expect(project.hardwares.length).to eq(count)
    end
  end
end
