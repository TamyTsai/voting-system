# rails g migration add_counter_cache_to_candidate

class AddCounterCacheToCandidate < ActiveRecord::Migration[6.1]
  def change # 會根據語法去猜 為 正向或反向，增加欄位的話，migration roll back時，就會知道要砍掉一個欄位
    add_column :candidates, :vote_logs_count, :integer, default: 0
    # 搜尋rails api add_column
    # add_column(table_name, column_name, type, **options) public
    # 為表格增加欄位

  end

  # 早期寫法
  # def up # 正向
  #   create
  # end
  # def down # 反向
  #   delete
  # end
end

# rails db:migrate
# schema.rb會長出 t.integer "vote_logs_count", default: 0
# 要做counter chache時，會將表格數量做count計算，然後把計算結果更新到vote_logs_count欄位
# 欄位命名慣例：資料表名稱（要被計算資料筆數的資料表）_count

# 再去vote_log.model加上counter_cache: true

