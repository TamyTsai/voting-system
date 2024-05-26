class CreateCandidates < ActiveRecord::Migration[6.1]
  def change
    create_table :candidates do |t| 
      # model名稱為 首字母大寫 單數（應用系統 物件），資料表 名稱為 首字母小寫 複數（含有 多個物件）（慣例） 
      t.string :name
      t.string :party
      t.integer :age
      t.text :politic
      t.integer :votes, default: 0 # 預設為0票

      t.timestamps
    end
  end
end

# 建完migration要跑rails db:migrate來具現化資料描述檔