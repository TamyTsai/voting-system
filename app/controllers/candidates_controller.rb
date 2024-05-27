class CandidatesController < ApplicationController # 繼承自ApplicationController才會有功能

    def index # controller的action（方法） # 對應 /candidates路徑（候選人清單頁面）
        # 沒有特別聲明的話，就會去views找同名html檔案（index.html.erb）
        @candidates = Candidate.all
        # 透過.all類別方法，將Candidate此類別（model）中的所有資料撈出來，指定給實體變數@candidates（因為撈了多筆資料，所用複數型）
        # ORM基本操作之R
        # Candidate.all 列出所有候選人（物件、model、資料表中的一筆資料）資料
        # Candidate.select('name') 同上，只選取name欄位
        # Candidate.where(name: 'Ruby') 找出所有name欄位是Ruby的資料
        # Candidate.order('age DESC') 依照年齡大小反向排序
        # Candidate.order(age: :desc) 同上
        # Candidate.limit(5) 只取出5筆資料
        
    end

    def show # 對應/candidates/:id路徑（單一候選人頁面）
        # 點擊第一個候選人頁面時，log顯示Parameters: {"id"=>"1"}
        # 路徑符合/candidates/:id此模式，id就會被捕捉起來，可以拿來放在實體變數之類的
        # 表示可以透過params這個hash，拿id這個key對應的值來用
        @candidate = Candidate.find_by(id: params[:id])
        # Candidate類別（model）有find_by方法

        # controller負責抓資料給 view要用的實體變數

        # ORM基本操作之R
        # Candidate.first 找出第一筆候選人（物件、model、資料表中的一筆資料）資料
        # Candidate.last 找到最後一筆資料
        # Candidate.find(1) 找到id = 1 的資料（出問題直接噴例外）
        # Candidate.find_by(id: 1) 找到id = 1 的資料（找不到時 給nil）（undefined method `name' for nil:NilClass）（nil沒有name方法）
        # Candidate.find_by_sql("SQL語法") 
        # Candidate.first_each do |candidate|   ....  end
        
    end

    # ORM基本操作之C：new、create

    def new # 對應/candidates/new路徑（新建候選人資料）
        # new方法會 建立 一筆資料，但還不會存到資料庫裡
        @candidate = Candidate.new # 建立 一筆資料（model、物件）
        # 沒有帶東西，全新物件
        # model：class Candidate < ApplicationRecord
        # 指定給一個變數，view才能拿到
        # 建立物件的寫法寫在controller會比寫在view好，view拿這裡給的實體變數呈現畫面就好
    end

    def create # 對應以POST動詞進入的/candidates路徑（將新建的候選人資料儲存）
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
        else # 若 寫入失敗（格式不對、驗證沒過...）（在model做後端驗證（進資料庫前的驗證））          
            # redirect_to '/candidates/new' 
            # 就不跳回候選人列表頁，而是停留在本頁面（新建候選人頁面），但此寫法會轉回全新頁面，導致所有資料都要重填
            # http沒有所謂的狀態，這頁寫好的東西，轉址後的網頁不會知道
            render :new 
            # 去new這個頁面，重新渲染一次（不是重新執行new方法（action）），是請view中的new頁面重畫一次
            # 本質上還是在create這個action中，並非執行new action
            # render就是要借new.html檔案來用
            # new.html檔案需要＠candidate 實體變數（所以才會在create action中，也寫一個跟new action中相同的 ＠candidate實體變數）（但也有 沒 這麼剛好（有同名實體變數）的狀況）
            # 這裡抓到的 ＠candidate實體變數 已經不像new action中是新創出來的，是裡頭已經有料（candidate_params）的 物件、model
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

    private # 作用範圍是 以下 直到 本class的end為止，所以要寫在最後
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