require 'spec_helper'

describe ProjectsController do
  before do
    hackday_org = FactoryGirl.create :hackday_organization
    @hackday = FactoryGirl.create :hackday, hackday_organization: hackday_org
    @project = FactoryGirl.create :project, hackday: @hackday
    @other_user = FactoryGirl.create :user
  end

  describe 'GET edit' do
    it 'if not owner of hackday org, should redirect to the hackday' do
      controller.stub current_user: @other_user
      get :edit, id: @project.id, hackday_id: @project.hackday_id
      expect(response).to redirect_to(hackday_url(@project.hackday))
    end

    it 'if owner of hackday, but project does not belong, should redirect to hackday' do
      project = FactoryGirl.create :project
      get :edit, id: project.id, hackday_id: @project.hackday_id
      expect(response).to redirect_to(hackday_url(@project.hackday))
    end
  end
end