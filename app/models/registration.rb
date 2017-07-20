class Registration < ApplicationRecord

  has_paper_trail

  STATUS = ["pending", "confirmed"]
  validates_inclusion_of :status, :in => STATUS
  validates_presence_of :status, :ticket_id
  validate :check_event_status, :on => :create

  attr_accessor :current_step
  validates_presence_of :name, :email, :cellphone, :if => :should_validate_basic_data?
  validates_presence_of :name, :email, :cellphone, :bio, :if => :should_validate_all_data?

  belongs_to :event
  belongs_to :ticket
  belongs_to :user, :optional => true

  before_validation :generate_uuid, :on => :create

  def to_param
    self.uuid
  end

  protected

  def generate_uuid
     self.uuid = SecureRandom.uuid
  end

  protected

  def should_validate_basic_data?
    current_step == 2   # 只有做到第二步需要验证
  end

  def should_validate_all_data?
    current_step == 3 || status == "confirmed "   #做到第三步，或最后状态是 confirmed 时需要验证
  end

  def check_event_status
    if self.event.status == "draft"
      errors.add(:base, "活动尚未开放报名")
    end
  end
end
