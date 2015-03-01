class Story < ActiveRecord::Base
  validates :title, presence: true 
  belongs_to :creator, :class_name => "User"
  has_many :memberships
  has_many :users, through: :memberships
  has_many :invites
  has_many :lines
end