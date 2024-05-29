# 引入counter cache的票數不會被紀錄（引入後，才開始在投票當下 同時更新候選人得票數欄位）
# 搜尋：rails api reset counter cache
# reset_counters(id, *counters（要計算的對象）, touch: nil) public
# rake -T ：看rails專案中有哪些rake可以用-->
# 去lib > tasks加任務

namespace :db do
    desc 'Reset Counter Cache!' # 任務描述
    task :reset_counter => :environment do
        #  => :environment 用以引入整個rails的環境，才能在task使用rails model
        puts "prepare to reset counter"
        Candidate.all.each do |candidate|
            Candidate.reset_counters(candidate.id, :vote_logs)
        end
        puts "done!"
    end
end

# rake db:reset_counter
# rails db:reset_counter
# 做一次就好（把使用counter cache之前的票數也更新到 候選人得票數欄位）

# 在軟體開發中，make是一個工具程式，經由讀取叫makefile的檔案，自動化建構軟體
# Rake為Ruby版的Make