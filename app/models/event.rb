class Event < ApplicationRecord
  belongs_to :user
  has_many :ticket_types, dependent: :destroy
end
