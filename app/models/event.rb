class Event < ApplicationRecord
  belongs_to :category, :optional => true

  STATUS = ["draft", "public", "private"]
  validates_inclusion_of :status, :in => STATUS

 validates_presence_of :name

 before_validation :generate_friendly_id, :on => :create

  def to_param
    self.friendly_id
  end

  protected

  def generate_friendly_id
    self.friendly_id ||= SecureRandom.uuid
  end
end
