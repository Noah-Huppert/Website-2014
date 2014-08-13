class CreateUserSessions < ActiveRecord::Migration
  def change
    create_table :user_sessions do |t|
      t.belongs_to :user
      
      t.string :session_id
      t.string :session_secret
      t.datetime :expires_on

      t.timestamps
    end
  end
end
