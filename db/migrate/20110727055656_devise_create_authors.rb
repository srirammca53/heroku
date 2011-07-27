class DeviseCreateAuthors < ActiveRecord::Migration
  def self.up
    create_table(:authors) do |t|
      t.database_authenticatable :null => false
      t.confirmable
      t.recoverable
      t.rememberable
      t.trackable
      # t.lockable :lock_strategy => :failed_attempts, :unlock_strategy => :both

      t.timestamps
    end

    add_index :authors, :email,                :unique => true
    add_index :authors, :confirmation_token,   :unique => true
    add_index :authors, :reset_password_token, :unique => true
    # add_index :authors, :unlock_token,         :unique => true
  end

  def self.down
    drop_table :authors
  end
end
