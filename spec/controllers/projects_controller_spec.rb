require 'spec_helper'

describe ProjectsController do
  include Devise::TestHelpers

  # This should return the minimal set of attributes required to create a valid
  # Book. As you add validations to Book, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { {project: { title: 'new' }} }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # BooksController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  let(:user) { FactoryGirl.create :user }

  before do
    sign_in user
  end

  describe 'GET index' do
    it 'assigns all projects as @projects' do
      project = user.projects.create! valid_attributes[:project]
      get :index, {}, valid_session
      assigns(:projects).should eq([project])
    end

    it 'redirect to sign in if not logged in' do
      sign_out :user
      get :index
      response.should redirect_to(new_user_session_path)
    end
  end

  describe 'POST create' do
    it 'redirect to sign in if not logged in' do
      sign_out :user
      post :create
      response.should redirect_to(new_user_session_path)
    end

    it 'creates new project' do
      expect{post :create, valid_attributes}.to change { user.projects.count}.by(1)
    end
  end

  describe 'DELETE destroy' do
    it 'redirect to sign in if not logged in' do
      sign_out :user
      delete :destroy, {id: 1}
      response.should redirect_to(new_user_session_path)
    end

    it 'delete project' do
      project = user.projects.create! valid_attributes[:project]
      expect{delete :destroy,  {id: project.id}}.to change { user.projects.count}.by(-1)
    end
  end

  describe 'PATCH update' do
    it 'redirect to sign in if not logged in' do
      sign_out :user
      patch :update, {id: 1}
      response.should redirect_to(new_user_session_path)
    end

    it 'updates project' do
      project = user.projects.create! valid_attributes[:project]
      patch :update,  {id: project.id, project: {title: 'changed'}}
      expect(user.projects.last.title).to eq 'changed'
    end
  end
end