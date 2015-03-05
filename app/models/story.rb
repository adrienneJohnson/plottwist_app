class Story < ActiveRecord::Base
  validates :title, presence: true
  validates :first_line, presence: true 
  belongs_to :creator, :class_name => "User"
  has_many :users, :through => :memberships
  has_many :memberships
  has_many :invites
  has_many :lines
end