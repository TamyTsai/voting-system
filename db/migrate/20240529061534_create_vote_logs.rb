# rails g model VoteLog candidate_id:integer ip_address:string
# rails g model VoteLog candidate:references ip_address
# candidate:references 會做出candidate_id欄位（數字型態）指向候選人流水編號

class CreateVoteLogs < ActiveRecord::Migration[6.1]
  def change
    create_table :vote_logs do |t|
      t.references :candidate, null: false, foreign_key: true
      t.string :ip_address

      t.timestamps
    end
  end
end

# rails db:migrate
# -- create_table(:vote_logs)

# 進入rails c
# VoteLog.all 可看見所有投票資料
