# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  describe 'not signed user' do
    it 'redirects to registraction path' do
      get :index

      expect(response).to redirect_to(controller: 'registration',
                                      action: 'new')
    end
  end

  describe 'signed user' do
    before do
      u = User.create!(email: 'aldo1@hodor.pl', password: 'password',
                       password_confirmation: 'password')
      session[:current_user_id] = u.id
    end

    describe 'GET #index' do
      it 'returns http success' do
        get :index
        expect(response).to be_successful
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
        expect(response).to be_successful
        expect(assigns(:task)).to eq(task)
      end
    end

    describe 'DELETE #destroy' do
      it 'deletes task' do
        task = Task.create(subject: 'pranie')

        expect do
          delete :destroy, params: { id: task }, format: :json
        end.to change(Task, :count).by(-1)
        expect(response).to be_successful
      end

      it 'destroy task and redirects ' do
        task = Task.create(subject: 'pranie')
        expect do
          delete :destroy, params: { id: task }
        end.to change(Task, :count).by(-1)
        expect(response).to have_http_status(:redirect)
      end
    end

    describe 'GET #search' do
      it 'searching by part of the subject' do
        Task.create(subject: 'Pranie')
        Task.create(subject: 'Prasowanie')
        Task.create(subject: 'Hodor')

        get :search, params: { query: 'Pra' }

        expect(response).to be_successful
        expect(JSON.parse(response.body)).to match_array(%w[Pranie Prasowanie])
      end
    end
  end
end
