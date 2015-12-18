#!/bin/bash

#
# Tools
#

mysqldump ghost_production -u root -proot > ghost_production.mysqldump

rm -rf content
cp -Rv /var/www/ghost/content .
rm -rf content/logs
git add .
git commit -a --amend --no-edit
git push -f

#
# Content
#

rm -rf master
mkdir master
cd master

cp ../README.md .
cp ../googlea47623b085a9b365.html .
cp ../favicon/* .

wget -r http://127.0.0.1:2368/
mv */* .
wget http://127.0.0.1:2368/sitemap.xml
wget http://127.0.0.1:2368/sitemap-pages.xml
wget http://127.0.0.1:2368/sitemap-posts.xml
wget http://127.0.0.1:2368/sitemap-authors.xml
wget http://127.0.0.1:2368/sitemap-tags.xml
wget http://127.0.0.1:2368/rss
mkdir -p assets/built
wget http://127.0.0.1:2368/assets/built/screen.css -O assets/built/screen.css
mkdir -p assets/js
wget http://127.0.0.1:2368/assets/js/jquery.fitvids.js -O assets/js/jquery.fitvids.js
wget http://127.0.0.1:2368/assets/js/jquery.fitvids.js -O assets/js/jquery.fitvids.js
wget http://127.0.0.1:2368/assets/js/infinitescroll.js -O assets/js/infinitescroll.js
mkdir -p public
wget http://127.0.0.1:2368/public/ghost-url.min.js -O public/ghost-url.min.js
wget http://127.0.0.1:2368/public/ghost-sdk.min.js -O public/ghost-sdk.min.js

find . -type f -exec sed -i 's/http:\/\/localhost:2368/https:\/\/bjurr.com/g' {} +
find . -type f -exec sed -i 's/rss\//rss/g' {} +

echo "bjurr.com" > CNAME

git init
git remote add origin git@github.com:tomasbjerre/bjurrcom.git
git add .
git commit -a -m "static content"

git push -f -u origin master
