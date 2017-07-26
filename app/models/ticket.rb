class Ticket < ApplicationRecord
  has_many :registrations
  validates_presence_of :name, :price
  belongs_to :event
end
