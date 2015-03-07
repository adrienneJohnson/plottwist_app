class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :phone, presence: true
  validates :email, presence: true

  has_many :stories, :foreign_key => :creator_id, :through => :memberships
  has_many :memberships
  has_many :invitations, :class_name => "Invite", :foreign_key => 'recipient_id'
  has_many :sent_invites, :class_name => "Invite", :foreign_key => 'sender_id'
  has_many :lines

  def self.search(search)
    where("email like ?", "%#{search}%")    
  end
end
