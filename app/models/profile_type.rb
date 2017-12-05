class ProfileType < ApplicationRecord
  has_many :profile_affiliations, foreign_key: "profileTypeId", dependent: :destroy
end
