require 'features/features_spec_helper'

feature "Priority management", js: true do
  let(:user) {User.create!(email: "123@123.123", password: "123123123")}
  let!(:project) { user.projects.create!(title: 'new_project') }
  let!(:task1) { project.tasks.create!(title: 'new_task1', priority: 0) }
  let!(:task2) { project.tasks.create!(title: 'new_task2', priority: 1) }

  before do
    login_as(user)
  end

  scenario "User moves task2 down" do
    visit root_path
    find("#task#{task2.id}").hover
    find("#task#{task2.id}").find(".down").click
    page.should have_selector('tbody tr:nth-child(1)', text: 'new_task1')
    page.should have_selector('tbody tr:nth-child(2)', text: 'new_task2')
  end

  scenario "User moves task1 up" do
    visit root_path
    find("#task#{task1.id}").hover
    find("#task#{task1.id}").find(".up").click
    page.should have_selector('tbody tr:nth-child(1)', text: 'new_task1')
    page.should have_selector('tbody tr:nth-child(2)', text: 'new_task2')
  end
end