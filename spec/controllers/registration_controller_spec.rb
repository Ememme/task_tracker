# frozen_string_literal: true
 require 'rails_helper'
 RSpec.describe RegistrationController, type: :controller do
  describe 'GET #new' do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end
  end
   describe 'POST #create' do
    let(:valid_params) do
      { user:
        { email: 'aldo@hodor.pl',
          password: 'YayPassword',
          password_confirmation: 'YayPassword' } }
    end
     let(:invalid_params) do
      { user:
        { email: 'aldo@hodor.pl',
          password: 'YayPassword',
          password_confirmation: 'noope' } }
    end
     it 'creates user profile' do
      expect do
        post :create, params: valid_params
      end.to change(User, :count).by(1)
      expect(response).to have_http_status(:redirect)
    end
     it 'checks password confirmation' do
      expect do
        post :create, params: invalid_params
      end.not_to change(User, :count)
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
