# encoding: utf-8
class Person
  include Mongoid::Document

  field :first_name, type: String
  field :last_name, type: String
  field :email, type: String
  field :login, type: String
  field :password, type: String

  validates_presence_of [:first_name, :last_name, :email, :login, :password, :confirm_password]
  validates_uniqueness_of [:email, :login]
  validates :first_name, :last_name, :login, length: { minimum: 2 }
  validates :password, :confirm_password, length: { minimum: 4, maximum: 16 }
  validate :validate_password
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  private

  def validate_password
    errors.add(:confirm_password, "does not match confirmation") if
        password != confirm_password
  end


  def authenticate

  end
end