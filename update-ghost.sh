#!/bin/bash
cd /var/www/ghost/
sudo npm i -g ghost-cli@latest
ghost update -V
cd -
