class AddAttachmentAvatarToAccounts < ActiveRecord::Migration[5.1]
  def change
    add_attachment :accounts, :avatar
  end
end
