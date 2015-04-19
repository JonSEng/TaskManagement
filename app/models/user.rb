class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable, :rememberable, :validatable, :omniauth_providers => [:google_oauth2]

  attr_accessible :email, :phone_number, :username, :provider, :first_name, :last_name, :picture

  def self.from_omniauth(auth)
    if user = User.find_by_email(auth.info.email)
      user.provider = auth.provider
    else
      user = User.create
      user.provider = auth.provider
      user.email = auth.info.email
      user.first_name = auth["info"]["first_name"]
      user.last_name = auth["info"]["last_name"]
      user.picture = auth["info"]["image"]
    end
    return user
  end

  def password_required?
    false
  end
end
