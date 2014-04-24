require 'features/features_spec_helper'

feature "Adding task", js: true do
  let(:user) { FactoryGirl.create :user }

  before do
    login_as(user)
  end

  scenario "User adds new task" do
    user.projects.create!(title: 'new_project')
    visit root_path
    within '#frmNewTask' do
      fill_in 'new_task_title', with: 'task1'
      click_button 'Add Task'
    end
    expect(page).to have_content 'task1'
  end

end