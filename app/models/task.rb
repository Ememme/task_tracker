class Task < ApplicationRecord
  validates :subject, presence: true, length: { minimum: 3 }
end
