# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Task, type: :model do
  it 'requires subject' do
    task = Task.new
    expect(task.valid?).to be_falsey
  end

  it 'accepts any subject' do
    task = Task.new(subject: 'Hodor!')
    expect(task.valid?).to be_truthy
  end
end
