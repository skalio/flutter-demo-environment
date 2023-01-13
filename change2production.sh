#!/bin/bash

# This script modifies the repository in a way that the built binaries are production binaries.

read -p "Do you really want to convert this repository from test mode to production mode? (y/n) " -n 1 -r
echo  
if [[ $REPLY =~ ^[Yy]$ ]]
then
  for PLATFORM in "ios" "macos" "android" "windows" "linux" "web"; do
    ./recursive_replace EnvironmentDemoTest EnvironmentDemo $PLATFORM	# executable name
    ./recursive_replace environmentdemotest environmentdemo $PLATFORM	# protocol name to start desktop app via browser
    ./recursive_replace com.environmentdemo.dev com.environmentdemo.app $PLATFORM	# bundle identifier / app id
    ./recursive_replace applinks:app.environmentdemo.dev applinks:app.environmentdemo.com $PLATFORM	# universal links
    ./recursive_replace webcredentials:app.environmentdemo.dev webcredentials:app.environmentdemo.com $PLATFORM	# web credentials
  done
fi
