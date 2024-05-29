# rails g model VoteLog candidate_id:integer ip_address:string
# rails g model VoteLog candidate:references ip_address
# candidate:references 會做出candidate_id欄位（數字型態）指向候選人流水編號

class VoteLog < ApplicationRecord
  belongs_to :candidate, counter_cache: true # candidate:references 會做出candidate_id欄位（數字型態）指向候選人流水編號（透過id欄位 模擬關係）
  # belongs_to不是設定，是 類別方法（作用在class VoteLog ）
  # belongs_to :candidate 會動態產生幾個實體方法：candidate  candidate=
  # counter_cache: true 就會在寫入票的同時，更新票數欄位（vote_logs_count：vote_logs的資料筆數）
end

# model名為VoteLog 檔名為vote_log