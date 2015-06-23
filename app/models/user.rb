class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

	enum role: {admin: 'admin', member: 'member'}


# 以下を追加
  has_many :rentals

  validates :name, presence: true

end
