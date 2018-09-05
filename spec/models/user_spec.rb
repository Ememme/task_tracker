# frozen_string_literal: true
 require 'rails_helper'
 RSpec.describe User, type: :model do
  it { should validate_uniqueness_of(:email) }
  it { should validate_presence_of(:email) }
  it { should have_secure_password }
   describe 'validates format of email' do
    it 'complains for wrong format' do
      user = User.new(email: 'bar')
      expect(user).to_not be_valid
      expect(user.errors[:email]).to eq ['is invalid']
    end
     it 'complains for wrong format' do
      user = User.new(email: 'bar@foo')
      expect(user).to_not be_valid
      expect(user.errors[:email]).to eq ['is invalid']
    end
     it 'accepts correct format' do
      user = User.new(email: 'bar@foo.pl')
      expect(user).to_not be_valid
      expect(user.errors[:email]).to be_blank
    end
  end
end
