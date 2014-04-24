require 'features/features_spec_helper'

feature "Projects management", js: true do
  let(:user) { FactoryGirl.create :user }

  before do
    login_as(user)
  end

  scenario "User adds new project" do
    visit root_path
    within '#frmNewProj' do
      fill_in 'new_proj_title', with: 'project1'
      click_button 'New project'
    end
    expect(page).to have_content 'project1'
  end

  scenario "User deletes project" do
    user.projects.create!(title: 'new_project')
    visit root_path
    page.find(".destroy").click

    expect(page).to_not have_content 'new_project'
  end

  scenario "User edits project title" do
    user.projects.create!(title: 'new_project')
    visit root_path
    page.find(".update").click
    fill_in "title", with: "project1"
    click_button 'Update Project'
    expect(page).to_not have_content 'new_project'
    expect(page).to have_content 'project1'
  end
end