# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'tasks/edit.html.erb', type: :view do
  it 'renders form' do
    assign(:task, Task.create(subject: "sth"))

    render

    expect(rendered).to match(/<form/)
  end
end
