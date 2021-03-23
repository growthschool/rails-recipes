class Event < ApplicationRecord

  STATUS = ["draft", "public", "private"]
  validates_inclusion_of :status, :in => STATUS

  validates_presence_of :name, :friendly_id
  validates_uniqueness_of :friendly_id
  validates_format_of :friendly_id, :with => /\A[a-z0-9\-]+\z/
  # 格式只限小寫英數字及橫線

  before_validation :generate_friendly_id, :on => :create

  belongs_to :category, :optional => true

  has_many :tickets, dependent: :destroy, :inverse_of => :event
  accepts_nested_attributes_for :tickets, :allow_destroy => true, :reject_if => :all_blank

  has_many :registrations, :dependent => :destroy

  include RankedModel
  ranks :row_order
  scope :only_public, -> { where( :status => "public" ) }
  scope :only_available, -> { where( :status => ["public", "private"] ) }

  def to_param
    # "#{self.id}-#{self.name}"
    self.friendly_id
  end

  protected
  def generate_friendly_id
    self.friendly_id ||= SecureRandom.uuid
  end

end
