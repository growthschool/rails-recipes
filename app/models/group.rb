class Group < ApplicationRecord
  has_many :memberships
  has_many :user, through: :memberships
end