class CandidatesController < ApplicationController # 繼承自ApplicationController才會有功能

    def index # controller的action（方法）
        # 沒有特別聲明的話，就會去views找同名html檔案（index.html.erb）
    end

    # ORM基本操作之C：new、create

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

        # 資料清洗
        # clean_params = params.require(:candidate).permit(:name, :party, :age, :politic)
        # 只允許 :candidate（Parameters hash中的key）這個hash 中， 的部分欄位（有人增加新欄位想送資料 該欄位就會被無視）
        # "candidate"=>{"name"=>"123", "party"=>"456", "age"=>"26", "politic"=>"123"}


        # @candidate = Candidate.new(params[:candidate]) # 建立 一筆資料
        # 以Candidate建立物件model時，將Parameters hash中:candidate key對應的value（候選人各輸入框的 名稱 及 其中的資料）傳送進來，對應到此model migration的欄位中

        @candidate = Candidate.new(candidate_params) # 建立 一筆資料
         # 以Candidate建立物件model時，將清洗過後的資料傳進該物件

        if @candidate.save # 若成功將候選人輸入框中的資料 寫入資料庫
            flash[:notice] = "Candidate created!"
            # 事情若完成 不管成功失敗 都給一個訊息，帶到下一頁（轉址頁面）的時候被印出來
            # 跳出來一次就會消失 
            # flash有點像hash 
            #:notice為key（慣例）（舊式hash寫法，key用符號）
            # "Candidate created!"為要提示的訊息（需要透過view呈現在畫面（轉址頁面））

            redirect_to '/candidates' # 跳回候選人列表頁
            # 資料還沒清洗過 的話，會被預設檔下來，出現ActiveModel::ForbiddenAttributesError 錯誤訊息
            # 表示需要 資料清洗
            # 雖然有token的保護，有心人士無法透過其他程式或網站傳送資料進來這裡的後端，但他們還是可以在我們的頁面上用開發者模式，編輯html，新增欄位，成功送更多資料到這裡的後端
        else # 若 寫入失敗
            # NG
        end

        # 可進rails console中控台 檢查資料寫入狀態
        # ORM基本操作之R
        # Candidate.all 列出所有候選人（物件、model、資料表中的一筆資料）資料
        # Candidate.select('name') 同上，只選取name欄位
        # Candidate.where(name: 'Ruby') 找出所有name欄位是Ruby的資料
        # Candidate.order('age DESC') 依照年齡大小反向排序
        # Candidate.order(age: :desc) 同上
        # Candidate.limit(5) 只取出5筆資料
    end
    # 於rails routes查得：動詞為POST的話  就會去/candidates路徑 找candidates控制器的 create方法（action）

    private
    def candidate_params
        params.require(:candidate).permit(:name, :party, :age, :politic) #省略return之寫法
        # return可適時省略，會自動 回傳 最後一行 的 執行結果
    end
    # 呼叫candidate_params時，就回傳params.require(:candidate).permit(:name, :party, :age, :politic) 
    # 此方法本身不需要被外部存取，只在這個class中會被用到（用來代替落落長的 資料清洗過的欄位資料），所以設為private方法
    # private：原則上只有 類別內部 可以操作，但實際上 只要沒有明確訊息接收者 都可以呼叫

end

# 命名慣例
# 類別名稱為CandidatesController 駝峰式
# 檔名為candidates_controller.rb 蛇式

# CandidatesController的相關views要放在 views/candidates/xxx.html.erb