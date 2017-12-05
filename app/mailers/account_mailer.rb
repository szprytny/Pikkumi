class AccountMailer < ApplicationMailer
    default :from => "pikkumi.ror@gmail.com"

    def registration_confirmation(user, token, url)
        @user = user
        @token = token
        @base_url = url
        mail(:to => "#{user.username} <#{user.email}>", :subject => "Pikkumi account verification.")
    end
end
