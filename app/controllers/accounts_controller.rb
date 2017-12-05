require 'digest'
class AccountsController < ApplicationController
  include SessionsHelper
  before_action :set_account, only: [:show, :edit, :update, :destroy]
  # GET /accounts
  # GET /accounts.json
  def index
    if current_user != nil and current_user.is_administrator
      @accounts = Account.all
    else
      redirect_to root_path
    end
  end

  # GET /accounts/1
  # GET /accounts/1.json
  def show

  end

  # GET /accounts/new
  def new
    @account = Account.new
  end

  # GET /accounts/1/edit
  def edit
    
  end

  # POST /accounts
  # POST /accounts.json
  def create
    @account = Account.new(account_params)
    @account.password_salt = Account.generate_salt
    @account.password_encoded = @account.generate_encoded_password(@account.password_encoded)
    respond_to do |format|
      if @account.save
        send_verification_email @account
        @profileAffiliation = ProfileAffiliation.new(profileTypeId: account_params[:profileType] || '3',accountId: @account.id)
        @profileAffiliation.account = @account
        @profileAffiliation.save
        format.html { redirect_to @account, notice: 'Account was successfully created.' }
        format.json { render :show, status: :created, location: @account }
      else
        format.html { render :new }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /accounts/1
  # PATCH/PUT /accounts/1.json
  def update
    respond_to do |format|
      if @account.update(account_params)
        @account.update_attributes({:password_encoded => @account.generate_encoded_password(@account.password_encoded)})
        update_profile_affiliations(@account, params[:profiletypes])
        format.html { redirect_to @account, notice: 'Account was successfully updated.'}
        format.json { render :show, status: :ok, location: @account }
      else
        format.html { render :edit }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accounts/1
  # DELETE /accounts/1.json
  def destroy
    @account.destroy
    respond_to do |format|
      format.html { redirect_to accounts_url, notice: 'Account was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def verify
    @account = Account.find_by_username(params[:username])
    @verifyCode = VerificationCode.where(:accountId => Account.find_by_username(params[:username]), :code => params[:code]).first
    if @account != nil
      if @verifyCode != nil and !@account.isVerified
        @account.update_attributes({:isVerified => true})
        VerificationCode.destroy(@verifyCode.id)
        flash.now[:notice] = 'Account of user <b>' + @account.username + '</b> has been verified succesfully.'
        render 'static_pages/home'
      elsif @account.isVerified 
        flash.now[:error] = 'Account of user <b>' + @account.username + '</b> has been already verified.'
        render 'static_pages/home'
      else
        flash.now[:error] = 'Activation link is not valid for user <b>' + @account.username + '</b>.<form class="button_to" method="get" action="/account/resend_verify"><input class="btn-small btn-danger " type="submit" value="Get activation link again."><input type="hidden" name="id" value="' + @account.id.to_s + '"></form> '
        render 'static_pages/home'
      end
    else
        flash.now[:error] = 'Activation link is not valid. User <b>' + params[:username] +  '</b> does not exist.'
        render 'static_pages/home'
    end
  end
  
  def do_send_verification_email
    @user = Account.find_by_id(params[:id])
    send_verification_email(@user)
    flash.now[:notice] = 'Activation link has been sent to <b>' + @user.email + ' </b>.'
    render 'static_pages/home'
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = Account.find_by_id(params[:id])
      if @account==nil
        flash.now[:error] = 'Account with id ' + params[:id] + ' does not exist.'
        render 'static_pages/home'
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def account_params
      params.require(:account).permit(:username, :password_encoded, :password_salt, :email, :isVerified, :profileType, :avatar)
    end

    def send_verification_email(user)
      @code = VerificationCode.new(:code => user.confirmation_token, :accountId => user.id)
      if @code.save
        @url = request.base_url
        AccountMailer.registration_confirmation(user, @code.code, @url).deliver
      end
    end

    def update_profile_affiliations(user, affiliation_ids)
      user.profile_affiliations.destroy_all
      affiliation_ids.each do |acc_aff|
        @profileAffiliation = ProfileAffiliation.new(profileTypeId: acc_aff)
        @profileAffiliation.account = user
        @profileAffiliation.save
      end
    end

end
