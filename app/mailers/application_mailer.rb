class ApplicationMailer < ActionMailer::Base
  default from: "from@example.com"

  def broker_confirmation_email(user)
    mail(to: user.email, subject: "Broker Confirmation Email")
  end

  def send_pending_admin_email(user)
    mail(to: user.email, subject: "Pending Admin Email")
  end

  def send_welcome_email(user)
    mail(to: user.email, subject: "Welcome to Our App")
  end

  def account_approved(user)
    @user = user
    mail(to: @user.email, subject: "Your Account is Successfully Approved")
  end

  def account_created(user)
    @user = user
    mail(to: @user.email, subject: "Your Account is Successfully Created")
  end
end
