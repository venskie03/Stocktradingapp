class ApplicationMailer < ActionMailer::Base
 def broker_confirmation_email(user)
  default from: "from@example.com"
  layout "mailer"
 end
 def send_pending_broker_email(user)
  default from: "from@example.com"
  layout "mailer"
 end
 def send_welcome_email(user)
  mail(to: user.email, subject: 'Welcome to Our App')
end

end
