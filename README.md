<!-- # README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ... -->


## 簡介
- 本專案為一個投票系統
- 以HTML、CSS及Ruby撰寫，為動態網頁
- 樣式部分以SCSS撰寫，提升程式碼可讀性
- 使用Bootstrap美化頁面
- 使用Rails框架製作網頁
- 使用SQLite資料庫儲存候選人及投票資料

## 功能
- C（create）：於首頁點擊新建候選人按鈕，進入新建候選人資料頁面
- R（read）：首頁可讀取已建立之候選人資料
- U（update）：於首頁點擊編輯按鈕，進入編輯更新單一已建立之候選人資料頁面
- D（delete）：於首頁點擊刪除按鈕，刪除單一已建立之候選人資料
- 於首頁候選人清單頁面點擊投票按鈕，可進行投票
- 各候選人得票數顯示於首頁候選人清單上（已使用rails counter cache解決N+1問題）
- 資料庫除了記錄各候選人得票數，亦記錄投票資訊（投票時間、投票者ip位置等），避免做票
- 候選人資料新建、更新、刪除及投票成功時，皆會於頁面上方跳出一次性提醒

<!-- ## 畫面 -->


## 安裝
以下皆為於macOS環境運行
### 安裝Ruby
```bash
$ brew install ruby
```
### 取得專案
```bash
$ git clone https://github.com/TamyTsai/voting-system.git
```
### 移動到專案內
```bash
$ cd voting-system
```
### 安裝相關套件
```bash
$ bundle install
```
### 啟動rails伺服器
```bash
$ rails s
```
### 開啟專案
在瀏覽器網址列輸入以下網址即可看到專案首頁
```bash
http://localhost:3000/candidates
```

## 主要資料夾及檔案說明
- app - 核心程式放置處
- bin - rails、webpack、yarn 基本指令放置處
- config- rails 的基本文件放置處
- db - 定義資料庫綱要（schema）、資料庫遷移（migration）之處
- lib - 自行定義檔案放置處（rake等）
- log - 本專案記錄檔放置處
- public - 本專案靜態檔案 (404、422、500 錯誤顯示畫面)放置處
- tmp - 臨時或暫時用文件放置處
- vender - 第三方文件放置處
- Gemfile：要安裝 Ruby 的套件放置處
- Gemfile.lock：當套件放置 /Gemfile 資料夾時，在終端機輸入 bundle install (可簡化為bundle)，會在此生成此套件的基本設定檔
- gitignore：這是指利用 git 做版本控制時，不想被 git 追蹤的話，將檔案名稱放置的文件。
- Rakefile：用來載入 rake 命令包含的任務


## 專案技術
- HTML
- CSS
    - SCSS
    - Bootstrap v5.3.3
- Ruby v2.7.8
    - Rails v6.1.7.7
- SQLite
