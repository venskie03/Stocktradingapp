
class UserMailer < ApplicationMailer
    default from: 'admin.mailer@gmail.com'
    layout 'mailer'

    def send_welcome_email(user)
      @user = user
      @url = '#'
      mail(to: @user.email, subject: 'Welcome!')
    end

    def send_pending_admin_email(user)
      @user = user
      @url = '#'
      mail(to: @user.email, subject: 'Pending: Confirmation Status')
    end

    def send_confirmation_admin_email(user)
      @user = user
      @url = '#'
      mail(to: @user.email, subject: 'Confirmed')
    end

    def account_approved(user)
      @user = user
      mail(to: @user.email, subject: 'Your Account is Successfully Approved')
    end
    def account_disapproved(user)
      @user = user
      mail(to: @user.email, subject: 'Your Account is Successfully dispproved')
    end
    def account_created(user)
      @user = user
      mail(to: @user.email, subject: 'Your Account is Successfully Created')
    end
    def account_updated(user)
      @user = user
      mail(to: @user.email, subject: 'Your Account is Successfully Updated')
    end
    def account_signup(user)
      @user = user
      mail(to: @user.email, subject: 'Your Account is Successfully Created')
    end
    def account_created_as_admin(user)
      @user = user
      mail(to: @user.email, subject: 'Your Account is Successfully Created')
    end
end
