
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
end