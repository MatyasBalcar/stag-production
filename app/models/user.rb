class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :predmets
  has_many :lectures

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  validates :email, presence: true
  validates :password, presence: true
  validates :password_confirmation, presence: true
  end