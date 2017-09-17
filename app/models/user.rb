class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :tweets, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true, length: { maximum: 20 }
  validates :email, presence: true,  format: { with: /\S+@\S+\.\S+/}

  def feed
   Tweet.where("user_id = ?", id)
  end

end
