class CreateGapiTokens < ActiveRecord::Migration
  def change
    create_table :gapi_tokens do |t|
      t.belongs_to :user

      t.string :access_token
      t.string :token_type
      t.datetime :expires_on
      t.string :refresh_token

      t.timestamps
    end
  end
end
