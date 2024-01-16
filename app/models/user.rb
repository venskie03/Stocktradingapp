class User < ApplicationRecord
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

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  after_create :send_admin_mail

  after_create :send_admin_confirmation

  before_create :skip_confirmation

  def active_for_authentication?
    super || application_pending?
  end

  def inactive_message
    confirmed? ? super : :not_confirmed
  end

  enum role: {user: 0, admin: 1}

  # broker_status
  enum broker_status: { application_pending: 0, pending_approval: 1, approved: 2 }


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

  def change_balance_by(amount)
    # byebug
    update(balance: balance + amount)
  end

  def role?(base_role)
    ROLES.index(base_role.to_s) <= ROLES.index(role)
  end

  private
  def register_as_broker
  self.update(broker_status: :application_pending)
  end



  def skip_confirmation
    self.confirmed_at = Time.current
  end

  def send_admin_mail
    if user_stocks == 'pending_approval'
      UserMailer.send_pending_admin_email(self).deliver_later

    else
      ApplicationMailer.send_welcome_email(self).deliver_later
    end

  end

end
