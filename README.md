# README
閱讀卡提諾論壇小說的精簡工具
Host on AWS http://ec2-52-76-158-43.ap-southeast-1.compute.amazonaws.com/

### 同步時程
* 每天同步卡提諾論壇::小說::長篇小說::第一頁的所有小說 (暫時關閉)
* 每天同步所有小說的最新章節

### OS
* Ubuntu Xenial (16.04.2 LTS)

### Packages required
* rvm
* nodejs
* postgresql-9.5
* monit
* nginx
* redis-server

### Ruby version
* ruby-2.3.3

### Ruby Gemset
* catty_novel

### Futures to-do for version 1.0
* support keyboard page nav
* support jump to chapter

### Futures to-do for version 2.0
* using vue.js to render pages
* loading 20 chapters in one request
