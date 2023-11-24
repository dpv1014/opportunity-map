class User < ApplicationRecord
  has_paper_trail
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: [:businessman, :admin]

  validates :role, presence: true

  def self.translate_role_enum
    {"businessman"=> "Empresario",  "admin"=>"Administrador"}
  end

  def roles_can_create
    return [] if businessman?

    return User.roles.keys if admin?

    User.roles.keys - ['admin']
  end
end
