class CandidatesController < ApplicationController # 繼承自ApplicationController才會有功能

    def index # controller的action（方法）
    end

end

# 命名慣例
# 類別名稱為CandidatesController 駝峰式
# 檔名為candidates_controller.rb 蛇式

# CandidatesController的相關views要放在 views/candidates/xxx.html.erb