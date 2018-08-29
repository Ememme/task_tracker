# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'fetch tasks' do
      Task.create(subject: 'Oh hi!')

      get :index

      expect(assigns(:task)).to be_a_new(Task)
      expect(assigns(:tasks)).to match_array(Task.all)
    end
  end

  describe 'GET #create' do
    it 'creates task' do
      expect do
        post :create, params: { task: { subject: 'Please work!' } }
      end.to change(Task, :count).by(1)
      expect(response).to have_http_status(:redirect)
    end

    it 'renders index' do
      expect do
        post :create, params: { task: { subject: '' } }
      end.to_not change(Task, :count)
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'GET #edit' do
    it 'edit task' do
      task = Task.create(subject: 'sth')
      get :edit, params: { id: task }
      expect(response).to have_http_status(:success)
      expect(assigns(:task)).to eq(task)
    end
  end

  describe 'GET #search' do
    it 'searching by part of the subject' do
      Task.create(subject: 'Pranie')
      Task.create(subject: 'Prasowanie')
      Task.create(subject: 'Hodor')

      get :search, params: { query: 'Pra' }

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)).to match_array(%w[Pranie Prasowanie])
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes task from list and redirects' do
      task = Task.create(subject: 'Task to delete')
      expect do
      delete :destroy, params: { id: task }
      end.to change(Task, :count).by(-1)
      expect(response).to be_succesful
    end

    it 'deletes task from list and creates JSON response' do
      task = Task.create(subject: 'Task to delete')
      expect do
      delete :destroy, params: { id: task }
      end.to change(Task, :count).by(-1)
      expect(response).to have_http_status(:redirect)
    end
  end

end
