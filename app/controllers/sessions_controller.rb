class SessionsController < ApplicationController
    include SessionsHelper

  def new
  end

  def create
    user = (Account.find_by_username(params[:session][:name]) || Account.find_by_email(params[:session][:name]))
    if user && user.is_password_correct(params[:session][:password])
      sign_in user
      redirect_back_or root_path
    else
      flash.now[:error] = 'Invalid Login/email/password combination'
      render 'static_pages/home'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end