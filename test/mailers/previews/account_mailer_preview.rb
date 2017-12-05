# Preview all emails at http://localhost:3000/rails/mailers/account_mailer
class AccountMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/account_mailer/registrationConfirmation
  def registrationConfirmation
    AccountMailer.registrationConfirmation
  end

end
