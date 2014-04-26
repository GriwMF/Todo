require 'features/features_spec_helper'

feature "Drag and drop", js: true do
  let(:user) { FactoryGirl.create :user }

  before do
    login_as(user)
  end

  scenario "User drags top task to bottom" do
    project = user.projects.create!(title: 'new_project')
    task1 = project.tasks.create!(title: 'new_task1', priority: 0)
    task2 = project.tasks.create!(title: 'new_task2', priority: 1)

    visit root_path

    task1_el = find("#task#{task1.id}")
    task2_el = find("#task#{task2.id}")
    task1_el.drag_to(task2_el)
    page.should have_selector('tbody tr:nth-child(1)', text: 'new_task1')
    page.should have_selector('tbody tr:nth-child(2)', text: 'new_task2')
  end
end