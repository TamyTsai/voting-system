class CreateCandidates < ActiveRecord::Migration[6.1]
  def change
    create_table :candidates do |t| 
      # model名稱為 首字母大寫 單數（應用系統 物件），資料表 名稱為 首字母小寫 複數（含有 多個物件）（慣例） 
      t.string :name
      t.string :party
      t.integer :age
      t.text :politic
      t.integer :votes, default: 0 # 預設為0票
      # 每個表格預設有一個叫做id的 流水編號欄位

      t.timestamps
      # timestamps為migration預設欄位，會轉換成created_at與updated_id這兩個時間欄位
      # 在 資料新增 或 更新 的時候，自動寫入當下時間
    end
  end
end

# 建完migration要跑rails db:migrate來具現化資料描述檔
