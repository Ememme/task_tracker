# frozen_string_literal: true
 require 'rails_helper'
 RSpec.describe 'registration/new.html.erb', type: :view do
  it 'renders form' do
    assign(:user, User.new)
     render
     expect(rendered).to match(/<form/)
  end
end
