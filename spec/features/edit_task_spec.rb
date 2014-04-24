require 'features/features_spec_helper'

feature "Editing task", js: true do
  let(:user) { FactoryGirl.create :user }

  before do
    login_as(user)
  end

  scenario "User edits project title" do
    project = user.projects.create!(title: 'new_project')
    project.tasks.create!(title: 'new_task', priority: 0)
    visit root_path
    within '#table-tasks' do
      find('tr').hover
      page.find(".update").click
    end
    fill_in "title", with: "task1"
    click_button 'Update Task'
    expect(page).to_not have_content 'new_task'
    expect(page).to have_content 'task1'
  end
end