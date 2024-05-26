class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end

# ActiveRecord 一種設計模式：把資料表的一筆資料 包裝成 一個物件，並可在 物件上 增加額外的 邏輯操作，讓資料的存取更便利