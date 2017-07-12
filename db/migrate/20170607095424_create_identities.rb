class CreateIdentities < ActiveRecord::Migration[5.1]
  def change
    create_table :identities do |t|
      t.integer :user_id
      t.string :provider
      t.string :uid
      t.string :email
      t.string :name
      t.string :token
      t.string :secret
      t.timestamps
    end
    add_index :identities, [:uid, :provider], unique: true
    add_index :identities, :user_id
  end
end
