require 'spec_helper'

def goto_valid_hackday
  @hackday_org = FactoryGirl.create :hackday_organization
  @hackday = FactoryGirl.create :hackday, hackday_organization: @hackday_org
  visit hackday_organization_hackday_path(@hackday_org, @hackday)
end

feature 'Project Creation' do
  scenario 'Valid project info' do
    goto_valid_hackday
    click_link 'Add Project'
    fill_in 'Name', with: 'TestProject'
    fill_in 'Description', with: 'This is an impressive project involving different things'
    click_button 'Save'
  end

  scenario 'duplicate existing project' do
    goto_valid_hackday
    ho = FactoryGirl.create :hackday_organization
    hd = FactoryGirl.create :hackday, hackday_organization: ho
    FactoryGirl.create :project, hackday: hd
    project = FactoryGirl.create :project, hackday: @hackday
    click_link 'Add Project'
    select project.id, from: 'existing_project_id'
  end
end
