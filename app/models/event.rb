class Event < ApplicationRecord

 mount_uploader :logo, EventLogoUploader
 mount_uploaders :images, EventImageUploader
 serialize :images, JSON

 belongs_to :category, :optional => true

 has_many :registrations, :dependent => :destroy
 has_many :registration_imports, :dependent => :destroy

 has_many :tickets, :dependent => :destroy, :inverse_of => :event
 accepts_nested_attributes_for :tickets, :allow_destroy => true, :reject_if => :all_blank

 has_many :attachments, :class_name => "EventAttachment", :dependent => :destroy
 accepts_nested_attributes_for :attachments, :allow_destroy => true, :reject_if => :all_blank

 include RankedModel
 ranks :row_order

 before_validation :generate_friendly_id, :on => :create

 STATUS = ["draft", "public", "private"]

 validates_inclusion_of :status, :in => STATUS

 validates_presence_of :name, :friendly_id

 validates_uniqueness_of :friendly_id
 validates_format_of :friendly_id, :with => /\A[a-z0-9\-]+\z/

 scope :only_public, -> { where( :status => "public" ) }
 scope :only_available, -> { where( :status => ["public", "private"] ) }

 def to_param
   self.friendly_id
 end

 protected

 def generate_friendly_id
   self.friendly_id ||= SecureRandom.uuid
 end

end
