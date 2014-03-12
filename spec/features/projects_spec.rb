require 'features_spec_helper'

def hackday(org)
  FactoryGirl.create :hackday, hackday_organization: org
end

feature 'Project Creation' do
  before do
    @hackday_org = FactoryGirl.create :hackday_organization
    @hackday = hackday @hackday_org
    visit hackday_organization_hackday_path(@hackday_org, @hackday)
  end

  scenario 'Valid project info' do
    click_link 'Add Project'
    fill_in 'Name', with: 'TestProject'
    fill_in 'Description', with: 'This is an impressive project involving different things'
    click_button 'Save'
    expect(page).to have_content('TestProject')
  end

  scenario 'duplicate existing project' do
    hd = FactoryGirl.create :hackday, hackday_organization: @hackday_org
    project = FactoryGirl.create :project, hackday: hd
    click_link 'Add Project'
    select project.name, from: 'existing_project_id'
    click_button 'Save'
    expect(page).to have_content(project.name)
  end

  scenario 'select hardware' do
    hardware = FactoryGirl.create :hardware, name: "Leap Motion"
    @hackday.hardwares << hardware
    @hackday.save
    click_link 'Add Project'
    fill_in 'Name', with: 'TestProject'
    fill_in 'Description', with: 'This is an impressive project involving different things'
    check 'Leap Motion'
    click_button 'Save'
    expect(page).to have_content('Leap Motion')
  end

  scenario 'not an owner' do
    @hackday_org.hackday_organizations_owners.destroy_all
    visit hackday_path(@hackday)
    expect(page).to_not have_content('Add Project')
  end
end

feature 'Edit Project' do
  before do
    @hackday_org = FactoryGirl.create :hackday_organization
    @hackday = hackday @hackday_org
  end
  scenario 'Valid info' do
    project = FactoryGirl.create :project, hackday: @hackday
    visit hackday_path(@hackday)
    click_link project.name
    fill_in 'Name', with: "Edited #{project.name}"
    click_button 'Save'
    expect(page).to have_content("Edited #{project.name}")
  end

  scenario 'not an owner' do
    @hackday_org.hackday_organizations_owners.destroy_all
    project = FactoryGirl.create :project, hackday: @hackday
    visit hackday_path(@hackday)
    expect(page).to_not have_css("edit_project_#{project.id}_link")
  end
end
