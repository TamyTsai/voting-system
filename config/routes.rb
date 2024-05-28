Rails.application.routes.draw do
  # resources :candidates # 做一個 候選人（符號） 相關的資源 出來 ＃複數 :複數
  # resources :candidates, path: 'member' # 修改路徑名稱（全站與candidates相關的路徑都用member取代）
  # 把candidates路徑全部開出來（8條路徑 對照 7個action（新增、修改、刪除等action））（方法）
  #   Prefix      Verb   URI Pattern（路徑）                                                                                 Controller#Action
  #   candidates   GET    /candidates(.:format)  候選人列表頁                                                                 candidates#index
  #                POST   /candidates(.:format)   傳送候選人的資料                                                            candidates#create
  # new_candidate  GET    /candidates/new(.:format)    新建候選人                                                             candidates#new
  # edit_candidate GET    /candidates/:id/edit(.:format)                                                                    candidates#edit
  #    candidate   GET    /candidates/:id(.:format)                                                                         candidates#show
  #                PATCH  /candidates/:id(.:format)                                                                         candidates#update
  #                PUT    /candidates/:id(.:format)                                                                         candidates#update
  #                DELETE /candidates/:id(.:format)                                                                         candidates#destroy

  # resources :candidates, only: [:index, :show]  ：只要index和show兩條路徑

  # /candidates(.:format)：所有候選人的列表
  # candidates#index：當網址為/candidates時，去找candidates controller，找index action來選
  # /candidates/:id(.:format)  列出id所指的候選人
  # candidates#show：當網址為/candidates/:id時，去找candidates controller，找show action來選
  # resources只負責告訴你要往哪裡去，至於有沒有對應的controller和action是另一回事

  # get '/hello.php', to: 'candidates#index'
  # 做一個/hello.php的網址 去找candidates控制器 的 index方法

  # post '/candidates/:id/vote', to: 'candidates#vote'
  # 動詞 路徑, to: 控制器#action
  # 自建route
  # candidate  POST   /candidates/:id/vote(.:format)   candidates#vote
  # 可以寫在candidates中

  resources :candidates do
    member do
      post :vote # 動詞 :action
    end
    # 幫原本的8條路徑再擴充其他路徑（帶id）
    # vote_candidate   POST   /candidates/:id/vote(.:format)       candidates#vote
    # post比較不容易被仿造（會檢查token） get只要知道路徑 就可以灌票

    # collection do
    #   post :vote
    # end
    # 幫原本的8條路徑再擴充其他路徑（不帶id）
    # vote_candidates POST   /candidates/vote(.:format)     candidates#vote

  end

end
 
# Rails設計風格 REST：把 網址 當作 資源 看待，讓網址的設計有標準

# GET /members => list all：把所有會員資料都列出來
# GET /members/2 => 看2號會員的資料
# GET /members/2/edit => 編輯2號會員的資料

# GET /books => 列出所有跟書相關的資料

# $ rails routes：列出專案中所有 路徑對照表

# GET    /candidates/:id/edit(.:format)  :id打2，2就會被捕捉起來，傳到controller裡面
# 類似 Sinatra get '/say_hello/:name' do params[:name] end # params[:name]會產生一個Hash，並去找出:name key所對應的value