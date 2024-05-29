class Candidate < ApplicationRecord
    # 後端驗證，進資料庫前的驗證  
    validates :name, presence: true
    # 注意:name為符號
    # 名字欄位必填，沒寫，就會寫入資料庫失敗

    has_many :vote_logs
    # has_many不是設定，是 類別方法（作用在class Candidate）
    # has_many :vote_logs會動態產生幾個實體方法：vote_logs  vote_logs=  build  create

end

# 類別的名字為常數 首字母大寫，但檔案名稱為小寫
# model名稱為 首字母大寫 單數（應用系統 物件），資料表 名稱為 首字母小寫 複數（含有 多個物件）