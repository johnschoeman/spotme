# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  avatar_url      :string
#  fb_name         :string
#  fb_id           :string
#  email           :string           not null
#

class User < ApplicationRecord
  has_secure_password
  after_initialize :ensure_session_token, :ensure_avatar, :ensure_password_if_fb

  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64
  end

  def ensure_avatar
    self.avatar_url ||= 'http://res.cloudinary.com/dfafbqoxx/image/upload/v1506546644/blank_user_oltxpb.png'
  end

  def ensure_password_if_fb
    if self.fb_id
      self.password ||= SecureRandom.urlsafe_base64
    end
  end

  # validates :username, :password_digest, :session_token, presence: true
  # validates :username, uniqueness: true
  validates :email, uniqueness: true
  validates :password, length: {minimum: 6, allow_nil: true}
  attr_reader :password

  def self.find_by_credentials(username, password)
    @user = User.find_by_username(username)
    if @user
      @user.is_password?(password) ? @user : nil
    else
      return nil
    end
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64
    self.save!
    self.session_token
  end
end
