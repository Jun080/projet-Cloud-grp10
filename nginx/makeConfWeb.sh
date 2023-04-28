#!/bin/bash
sed -e "s/MYUSERNAME/$1/" -e "s/MYDOMAIN/$2/" templateSite > /etc/nginx/sites-enabled/$2
