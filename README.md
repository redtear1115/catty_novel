# README
閱讀卡提諾論壇的精簡工具
Host on heroku https://catty-novel-9487.herokuapp.com/

### OS
* Ubuntu 14.04.5 LTS

### Packages required
* rvm
* nodejs
* postgresql-9.5
* postgresql-server-dev-9.5
* monit
* nginx
* redis-server

### Database
* Postgres SQL 9.6.1

### Ruby version
* ruby-2.3.3

### Ruby Gemset
* catty_novel

### 同步時程
* 每天 [04:00 UTC] 同步卡提諾論壇::小說::長篇小說::第一頁的所有小說 (未啟用)
* 每天 [00:00, 08:00, 16:00 UTC] 同步小說的最新章節

### Future
* interface to enter new novels & collections
* interface to search novels
* using vue.js to render pages
* automatically loading next chapter
* support another source website, maybe...