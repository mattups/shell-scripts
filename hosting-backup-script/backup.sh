#!/bin/sh

_bkp_dir="/root/backups"

_domain="example.com"
_www="/home/example/public_html"
_db_user="example_admin"
_db_pass="example_pass"
_db_name="example_db"

_now=$(date +"%Y-%m-%d_%H%M")
_bkp_sql="$_bkp_dir/$_domain/db/$_now.sql"
_bkp_files="$_bkp_dir/$_domain/files/$_now.tar.gz"

# Create backup directories if don't exist
mkdir -p "$_bkp_dir/$_domain/db"
mkdir -p "$_bkp_dir/$_domain/files"

# MySQL backup
mysqldump -u ${_db_user} -p${_db_pass} ${_db_name} > "$_bkp_sql"

# public_html backup
tar -zcvf "${_bkp_files}" "${_www}"
