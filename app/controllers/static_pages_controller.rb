class StaticPagesController < ApplicationController
  include SessionsHelper
  def home
    @user = current_user
  end

  def about
  end

  def contact
  end
end
