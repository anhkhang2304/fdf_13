class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable,
    :omniauthable, omniauth_providers: [:facebook, :google_oauth2]

  has_many :feedbacks
  has_many :comments
  has_many :orders

  validates :name, presence: true, length: {maximum: 50}
  validates :mobile, numericality: true, allow_blank: true

  def self.from_omniauth auth
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.name = auth.info.name
      user.password = Devise.friendly_token[0,20]
      user.provider = auth.provider
      user.uid = auth.uid
    end
  end

  def admin?
    self.roles == 1
  end
end
