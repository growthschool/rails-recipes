class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def display_name
    self.email.split("@").first
  end

  has_many :memberships
  has_many :groups, :through => :memberships
  has_one :profile
  has_many :registrations

  accepts_nested_attributes_for :profile

end
