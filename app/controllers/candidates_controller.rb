class CandidatesController < ApplicationController # 繼承自ApplicationController才會有功能

    def index # controller的action（方法）
        # 沒有特別聲明的話，就會去views找同名html檔案（index.html.erb）
    end

    # C：new、create

    def new # 對應/candidates/new路徑
        # new方法會 建立 一筆資料，但還不會存到資料庫裡
        @candidate = Candidate.new # 建立 一筆資料（model、物件）
        # model：class Candidate < ApplicationRecord
        # 指定給一個變數，view才能拿到
        # 建立物件的寫法寫在controller會比寫在view好，view拿這裡給的實體變數呈現畫面就好
    end

    def create # 對應以POST動詞進入的/candidates路徑
        # create會 建立 一筆資料，並直接寫入 資料庫裡（寫入失敗時，會roll back回來） 

        # debugger 
        # 中斷點 # 表單點擊送出時，會暫停，供開發者到log除錯
        # 輸入params、params[:candidate]、params[:candidate][:name]...，以查看想知道的hash key 中的 value
        # :candidate是符號，舊式hash寫法下的key
        # 無窮迴圈，輸入continue以繼續
        @candidate = Candidate.new(params[:candidate]) # 建立 一筆資料
        # 以Candidate建立物件model時，將Parameters hash中:candidate key對應的value（候選人各輸入框的 名稱 及 其中的資料）傳送進來，對應到此model migration的欄位中

        if @candidate.save # 若成功將候選人輸入框中的資料 寫入資料庫
            rederect_to '/candidates' # 跳回候選人列表頁
            # 資料還沒清洗過，會被預設檔下來，出現ActiveModel::ForbiddenAttributesError 錯誤訊息
            # 雖然有token的保護，有心人士無法透過其他程式或網站傳送資料進來這裡的後端，但他們還是可以在我們的頁面上用開發者模式，編輯html，新增欄位，成功送更多資料到這裡的後端
        else # 若 寫入失敗
        end

    end
    # 於rails routes查得：動詞為POST的話  就會去/candidates路徑 找candidates控制器的 create方法（action）

end

# 命名慣例
# 類別名稱為CandidatesController 駝峰式
# 檔名為candidates_controller.rb 蛇式

# CandidatesController的相關views要放在 views/candidates/xxx.html.erb