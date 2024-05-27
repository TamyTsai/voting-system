class Candidate < ApplicationRecord
    # 後端驗證，進資料庫前的驗證  
    validates :name, presence: true
    # 注意:name為符號
    # 名字欄位必填，沒寫，就會寫入資料庫失敗

end

# 類別的名字為常數 首字母大寫，但檔案名稱為小寫
# model名稱為 首字母大寫 單數（應用系統 物件），資料表 名稱為 首字母小寫 複數（含有 多個物件）