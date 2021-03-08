class Ticket < ApplicationRecord
  validates_presence_of :name, :price
  belongs_to :event
  has_many :registrations
end
