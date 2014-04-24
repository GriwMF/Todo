require 'spec_helper'

describe TasksController do
  include Devise::TestHelpers

  # This should return the minimal set of attributes required to create a valid
  # Book. As you add validations to Book, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { {task: { title: 'new', priority: '0' }, :format => 'json'} }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # BooksController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  let(:user) { FactoryGirl.create :user }
  let(:project) { user.projects.create!(title: "123123123")}


  before do
    sign_in user
  end

  describe 'POST create' do
    it 'redirect to sign in if not logged in' do
      sign_out :user
      post :create, {project_id: 1}
      response.should redirect_to(new_user_session_path)
    end

    it 'creates new task' do
      expect{post :create, valid_attributes.merge(project_id: project.id)}.to change { Task.all.count}.by(1)
    end
  end

  describe 'DELETE destroy' do
    it 'redirect to sign in if not logged in' do
      sign_out :user
      delete :destroy, {project_id: 1, id: 1}
      response.should redirect_to(new_user_session_path)
    end

    it 'delete project' do
      task = project.tasks.create! valid_attributes[:task]
      expect{delete :destroy,  {project_id: project.id, id: task.id, format: 'json'}}.to change { Task.all.count }.by(-1)
    end
  end

  describe 'PATCH update' do
    it 'redirect to sign in if not logged in' do
      sign_out :user
      patch :update, {project_id: 1, id: 1}
      response.should redirect_to(new_user_session_path)
    end

    it 'updates project' do
      task = project.tasks.create! valid_attributes[:task]
      patch :update,  {project_id: project.id, id: task.id, format: 'json', task: {title: 'changed'}}
      expect(Task.find(task).title).to eq 'changed'
    end
  end
end