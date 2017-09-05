#!/usr/bin/env bash

while true
do
  echo "`date`: Fetching"
  bundle exec parse_iono.rb
  sleep 300
done
