class CreateReg < ActiveRecord::Migration
  def change
    create_table :twitter_users do |t|
      t.string :name_user
    end

    create_table :tweets do |t|
      t.belongs_to :twitter_user, index: true
      t.string :tweet_w
      t.timestamp :created_at
      t.timestamp :updated_at
    end
  end
end
