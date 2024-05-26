class CandidatesController < ApplicationController # 繼承自ApplicationController才會有功能

    def index # controller的action（方法）
        # 沒有特別聲明的話，就會去views找同名html檔案（index.html.erb）
    end

    def new # 對應/candidates/new路徑
    end

    def create # 對應以POST動詞進入的/candidates路徑
    end
    # 於rails routes查得：動詞為POST的話  就會去/candidates路徑 找candidates控制器的 create方法（action）

end

# 命名慣例
# 類別名稱為CandidatesController 駝峰式
# 檔名為candidates_controller.rb 蛇式

# CandidatesController的相關views要放在 views/candidates/xxx.html.erb