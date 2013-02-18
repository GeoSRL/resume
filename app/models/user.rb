require 'digest/sha2'

class User < ActiveRecord::Base
  # has_many :posts

  attr_accessor :password, :password_confirmation
  attr_protected :id, :hashed_pwd

  validates_confirmation_of :password, :password_confirmation

  validates :email, :password, :password_confirmation, :presence => :true
  validates :id, :email, :uniqueness => :true

  before_create do
  	self.hashed_pwd = self.encrypt(self.password)
  end

  def self.authenticate(email, password)
    logger.debug "password"
  	return nil if email && password == ''
  	u = find_by_email(email)
  	return nil if u.nil? 
  	return u if self.encrypt(password) == u.hashed_pwd 
  end

  protected

  def self.encrypt(pass)
  	return Digest::SHA512.hexdigest(pass)
  end

end
