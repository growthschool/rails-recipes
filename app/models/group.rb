class Group < ApplicationRecord
  has_many :users, :through => :memberships
  has_many :memberships
end
