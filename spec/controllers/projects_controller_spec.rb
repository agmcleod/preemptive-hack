require 'spec_helper'

describe ProjectsController do
  before do
    hackday_org = FactoryGirl.create :hackday_organization
    @hackday = FactoryGirl.create :hackday, hackday_organization: hackday_org
    @project = FactoryGirl.create :project, hackday: @hackday
    @other_user = FactoryGirl.create :user
  end

  describe 'DELETE destroy' do
    it 'if not owner of hackday org, should redirect to the hackday' do
      controller.stub current_user: @other_user
      delete :destroy, id: @project.id, hackday_id: @project.hackday_id
      expect(response).to redirect_to(hackday_url(@project.hackday))
    end

    it 'if owner of hackday, but project does not belong, should redirect to hackday' do
      project = FactoryGirl.create :project
      delete :destroy, id: project.id, hackday_id: @project.hackday_id
      expect(response).to redirect_to(hackday_url(@project.hackday))
    end

    it 'if owner of hackday, but project does not belong, project should still exist' do
      project = FactoryGirl.create :project
      delete :destroy, id: project.id, hackday_id: @project.hackday_id
      expect(Project.find_by_id(project.id)).to_not be_nil
    end
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

  describe 'PUT update' do
    it 'if not owner of hackday org, should redirect to the hackday' do
      controller.stub current_user: @other_user
      put :update, id: @project.id, hackday_id: @project.hackday_id, project: { name: "New name" }
      expect(response).to redirect_to(hackday_url(@project.hackday))
    end

    it 'if owner of hackday, but project does not belong, should redirect to hackday' do
      project = FactoryGirl.create :project
      put :update, id: project.id, hackday_id: @project.hackday_id, project: { name: "New name" }
      expect(response).to redirect_to(hackday_url(@project.hackday))
    end

    it 'if owner of hackday, but project does not belong, project should not get updated' do
      project = FactoryGirl.create :project
      put :update, id: project.id, hackday_id: @project.hackday_id, project: { name: "New name" }
      expect(Project.find_by_id(project.id).name).to_not eq('New name')
    end
  end
end