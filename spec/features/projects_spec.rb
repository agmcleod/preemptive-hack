require 'spec_helper'

feature 'Feature: Project Creation' do
  background do
    login_for_feature
    @hackday_org = FactoryGirl.create :hackday_organization
    @hackday = FactoryGirl.create :hackday, hackday_organization: @hackday_org
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

feature 'Feature: Edit Project' do
  background do
    login_for_feature
    @hackday_org = FactoryGirl.create :hackday_organization
    @hackday = FactoryGirl.create :hackday, hackday_organization: @hackday_org
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

feature 'Feature: Remove project' do
  background do
    login_for_feature
    @hackday_org = FactoryGirl.create :hackday_organization
    @hackday = FactoryGirl.create :hackday, hackday_organization: @hackday_org
  end

  scenario 'an owner' do
    FactoryGirl.create :project, hackday: @hackday
    visit hackday_path(@hackday)
    within(".projects") do
      click_link 'Delete Project'
    end
    expect(Project.count).to eq(0)
  end

  scenario 'not an owner' do
    @hackday_org.hackday_organizations_owners.destroy_all
    project = FactoryGirl.create :project, hackday: @hackday
    visit hackday_path(@hackday)
    within '.projects' do
      expect(page).to_not have_text('Delete Project')
    end
  end
end