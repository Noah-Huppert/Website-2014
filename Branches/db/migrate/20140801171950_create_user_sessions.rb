class CreateUserSessions < ActiveRecord::Migration
  def change
    create_table :user_sessions do |t|
      t.belongs_to :user
      t.string :sid
      t.string :secret
      t.datetime :expires_on

      #t.references :user, index: true

      t.timestamps
    end
  end
end
