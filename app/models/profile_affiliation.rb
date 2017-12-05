class ProfileAffiliation < ApplicationRecord
    belongs_to :account, foreign_key: "accountId"
end
