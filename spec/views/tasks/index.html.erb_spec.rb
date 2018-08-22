# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'tasks/index.html.erb', type: :view do
  it 'renders form' do
    assign(:task, Task.new)
    assign(:tasks, [])

    render

    expect(rendered).to match(/<form/)
  end

  it 'renders form' do
    assign(:task, Task.new)
    assign(:tasks, [Task.create(subject: 'Pranie'),
                    Task.create(subject: 'Arghh!')])

    render

    expect(rendered).to match('Pranie')
    expect(rendered).to match('Arghh!')
  end
end
