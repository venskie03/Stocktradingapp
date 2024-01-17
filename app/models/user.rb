class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :user_stocks, dependent: :destroy
  has_many :stocks, through: :user_stocks
  has_many :orders, dependent: :destroy
  has_many :transaction_records,
           lambda { |user|
             # Removes default where clause of searching for user_id
             # Since user_id does not exist, cannot create through User.find(n).transaction_records.create!()
             unscope(:where).where(buyer: user)
           }, dependent: :destroy,
           inverse_of: :buyer

  # after_create :send_admin_mail

  after_create :notify_user_if_created_by_admin


  # Validations
  validates :email, presence: true,
                    uniqueness: true
  validates :username, presence: true
  validates :role, presence: true
  validates :balance, numericality: { greater_than_or_equal_to: 0 }

  # Role Inheritance using CanCanCan
  ROLES = %w[buyer admin].freeze

  def sufficient_balance?(amount)
    balance >= amount
  end

  def pending_approval?
    user_status == 'pending_approval'
  end

  def active_for_authentication?
    super || user_status == 'pending_approval'
  end

  def change_balance_by(amount)
    # byebug
    update(balance: balance + amount)
  end

  def role?(base_role)
    ROLES.index(base_role.to_s) <= ROLES.index(role)
  end
  private


  def notify_user_if_created_by_admin
    if role == "admin"
  UserMailer.account_created_by_admin_email(self).deliver_now
    end
  end

end
