#! /usr/bin/env bash


lftp -c "open -u ekstremedia.no,third32 ftp.ekstremedia.no; put $1"
