require 'digest'

class Account < ApplicationRecord

  before_save { self.email = email.downcase }
  before_save :create_remember_token

  has_attached_file :avatar,:path => "/accounts/avatars/:id/:style/:filename",:url => "/avatars/:id/:style/:filename", :default_url => "/accounts/x.png"
  validates :avatar,  presence: true
  validates_attachment_content_type :avatar, content_type: /\Aimage/
  do_not_validate_attachment_file_type :avatar

  validates :username,  presence: true, length: { maximum: 50 }
  validates :password_encoded,  presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
                    
  has_many :profile_affiliations, foreign_key: "accountId", dependent: :destroy

    def self.generate_salt
        return Digest::SHA256.base64digest Random.rand(14241).to_s
    end

    def generate_encoded_password(password)
        return Digest::SHA256.base64digest password+self.password_salt
    end

    def is_password_correct(password)
        return generate_encoded_password(password) == self.password_encoded 
    end
    
    def is_administrator
        self.get_profile_affiliations.each do |affiliation|
            if ProfileType.where(:id => affiliation.profileTypeId).first.typeName == "admin"
                return true
            end
        end
        return false
    end

    def get_profile_affiliations
        return ProfileAffiliation.where(:accountId => self.id)
    end

    private def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end

    public
    def confirmation_token
        return "pikkumi_"+SecureRandom.urlsafe_base64.to_s
    end

end