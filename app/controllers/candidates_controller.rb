class CandidatesController < ApplicationController # 繼承自ApplicationController才會有功能

    # before_action :find_candidate
    # 所有方法執行action前都先做find_candidate方法
    before_action :find_candidate, only: [:show, :edit, :update, :destroy, :vote]
    # 在這5個action執行前，先做find_candidtae方法
    # before_action :find_candidate, except: [:new, :create, :index]
    # 反向寫法
    
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
         
        # 抓出要讀取顯示（R）的資料（before_action已做）

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

    def new # 對應/candidates/new路徑（新建候選人資料）
        @candidate = Candidate.new # 建立 一筆資料（model、物件） # new方法會 建立 一筆資料，但還不會存到資料庫裡  # ORM基本操作之C：new、create
        # 沒有帶東西，全新物件
        # model：class Candidate < ApplicationRecord
        # 指定給一個變數，view才能拿到
        # 建立物件的寫法寫在controller會比寫在view好，view拿這裡給的實體變數呈現畫面就好
    end

    def create # 對應以POST動詞進入的/candidates路徑（將新建的候選人資料儲存）
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
            # flash[:notice] = "Candidate created!"
            # 事情若完成 不管成功失敗 都給一個訊息，帶到下一頁（轉址頁面）的時候被印出來
            # 跳出來一次就會消失 
            # flash有點像hash 
            #:notice為key（慣例）（舊式hash寫法，key用符號）
            # "Candidate created!"為要提示的訊息（需要透過view呈現在畫面（轉址頁面））

            # redirect_to '/candidates' # 跳回候選人列表頁
            # 資料還沒清洗過 的話，會被預設檔下來，出現ActiveModel::ForbiddenAttributesError 錯誤訊息
            # 表示需要 資料清洗
            # 雖然有token的保護，有心人士無法透過其他程式或網站傳送資料進來這裡的後端，但他們還是可以在我們的頁面上用開發者模式，編輯html，新增欄位，成功送更多資料到這裡的後端

            redirect_to '/candidates', notice: "Candidate created!"
            # 在離開頁面時，給一個flash，flash的key為notice
            # 失敗的話可以用alert這個key
            # notice與alert為特化版的key
            # 舊版rails沒有這種寫法

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

    def edit # 對應/candidates/:id/edit路徑（編輯單一候選人資料）
        # 要先抓到要編輯的候選人資料（before_action已做）
        
    end

    def update # 對應以PATCH動詞（事實上是POST PATCH是模擬的）進入的/candidates/:id路徑（將更新的候選人資料儲存）
        # candidate   PATCH  /candidates/:id(.:format)  candidates#update 
         
        # 抓出要更新（U）的資料（before_action已做）

        # 需要重抓候選人資料，因為http沒有狀態，上一個頁面做的事，下一個頁面不知道
        # 到新頁面後只有id，所以要重做物件

        if @candidate.update(candidate_params) # 成功更新資料時
        # ORM基本操作之U
        # update()
        # update_attributes()
        # update_all()
        # 給一包清洗過的資料
            # flash[:notice] = "Candidate updated!"
            # redirect_to '/candidates' # 回到候選人列表頁
            redirect_to '/candidates', notice: "Candidate updated!"
        else
            render :edit
            # 去edit這個頁面，重新渲染一次（不是重新執行edit方法（action）），是請view中的edit頁面重畫一次
        end

    end

    def destroy # 對應以 DELETE動詞進入的/candidates/:id路徑（刪除候選人資料）
        # candidate DELETE /candidates/:id(.:format)  candidates#destroy 
        
        # 抓出要刪除（D）的資料（before_action已做）

        @candidate.destroy
        # ORM基本操作之D
        # delete （直接刪掉）
        # destroy （會經歷一連串callback）（真的把資料刪除，就不回來，由資料庫中抹除） 
        # destroy_all(condition = nil)
        # flash[:notice] = "Candidate deleted!"
        # redirect_to '/candidates' # 回到候選人列表頁
        redirect_to '/candidates', notice: "Candidate deleted!"

        # 抓資料
        # 刪資料
        # 跳提示
        # 重新導向頁面

    end

    def vote # 對應以 POST動詞 進入的 /candidates/:id/vote路徑
        # vote_candidate   POST   /candidates/:id/vote(.:format)       candidates#vote

        # 抓出要被投票的候選人（網址的:id會被抓下來）（before_action已做）

        # 從vote角度看記錄（由 選票 本身 建立相關欄位與值）（票投給誰、投票者ip）
        # v = VoteLog.create(candidate: @candidate, ip_address: request.remote_ip)
        # create會建立一筆資料，並直接寫入資料庫裡
        # v = VoteLog.new(candidate: @candidate, ip_address: request.remote_ip)
        # v.save
        # new方法不會寫入資料庫，只會在記憶體先建構東西出來（建立一筆物件，但還不會存到資料庫裡），等save的時候才會寫入資料庫
        # 用VoteLog類別（model）建一個物件，初始化裡面就帶了兩個參數
        # 候選人欄位就裝前面用find_by加網址id抓出來的候選人
        # 對request物件使用remote_ip方法，可以得到投票當下的ip位置

        # 從候選人角度看vote
        # 一個候選人有很多筆 被投票紀錄（投票者ip）
        @candidate.vote_logs.create(ip_address: request.remote_ip)
        # 由單一候選人的被投票記錄 來建立相關欄位與值（只需要再帶 投票者ip）
        # g model的時候有設定reference，所以class VoteLog 有 belongs_to :candidate，但 class Candidate 不會自動增加相關設定（因為不知道你要一對一還是一對多）
        # 手動去candidate model 設定 has_many :vote_logs 後，這裡才會有vote_logs方法可以用

        # @candidate.votes += 1
        # @candidate.increment(:votes)
        # 票數欄位（資料庫的票數欄位）
        # 忘記欄位名稱 可以去db schema看
        # increment方法是rails modle提供的
        # @candidate.save

        # flash[:notice] = "Voted!"
        # redirect_to '/candidates' # 回到候選人列表頁
        redirect_to '/candidates', notice: "Voted!"

        # 抓資料
        # 更新資料
        # 存檔（寫進資料庫）
        # 跳提示
    end

    private # 作用範圍是 以下 直到 本class的end為止，所以要寫在最後
    def candidate_params
        params.require(:candidate).permit(:name, :party, :age, :politic) #省略return之寫法
        # return可適時省略，會自動 回傳 最後一行 的 執行結果
    end
    # 呼叫candidate_params時，就回傳params.require(:candidate).permit(:name, :party, :age, :politic) 
    # 此方法本身不需要被外部存取，只在這個class中會被用到（用來代替落落長的 資料清洗過的欄位資料），所以設為private方法
    # private：原則上只有 類別內部 可以操作，但實際上 只要沒有明確訊息接收者 都可以呼叫

    # 資料清洗
    # clean_params = params.require(:candidate).permit(:name, :party, :age, :politic)
    # 只允許 :candidate（Parameters hash中的key）這個hash 中， 的部分欄位（有人增加新欄位想送資料 該欄位就會被無視）
    # "candidate"=>{"name"=>"123", "party"=>"456", "age"=>"26", "politic"=>"123"}

    def find_candidate
        @candidate = Candidate.find_by(id: params[:id])
    end

end

# 命名慣例
# 類別名稱為CandidatesController 駝峰式
# 檔名為candidates_controller.rb 蛇式

# CandidatesController的相關views要放在 views/candidates/xxx.html.erb

# 於rails console輸入
# c1 = Candidate.new 新建立一個物件（model）
# c1 #<Candidate id: nil, name: nil, party: nil, age: nil, politic: nil, votes: 0, created_at: nil, updated_at: nil> (空的)（在記憶體上飄，還沒寫進資料庫內）
# c1.save（會出現false）（因為c1還沒做驗證（name欄位在model中已經設定必填））
# begin transaction rollback transaction：交易無效 不會把資料寫進資料庫 回到交易前狀態
# c1.errors 問c1物件有沒有error方法
# c1.any? 問c1物件有沒有任何東西
# c1.errors.any? 問c1物件有沒有任何錯誤 (還沒使用.save試圖寫進資料庫 做驗證前 不會有錯，.save後就會變有錯)
# c1.errors.full_messages 印出目前有哪些錯（用陣列裝著所有錯誤）（=> ["Name can't be blank"] ）
# create會 建立 一筆資料，並直接寫入 資料庫裡（寫入失敗時，會roll back回來） 

