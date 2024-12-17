#!/bin/bash

# Configurations
REPO_URL="https://github.com/lokesh-wagh/cc-demo.git"
BACKEND_DIR="/home/lokesh/Desktop/cc/cc-demo"
BRANCH="master"  # which branch to pull from
BACKEND_PORT=3000  # just to show to the terminal

#pull changes and merge them
echo "Pulling the latest changes from GitHub..."
cd $BACKEND_DIR || { echo "Directory not found: $BACKEND_DIR"; exit 1; }
git fetch --all
git checkout $BRANCH
git pull origin $BRANCH
echo "Successfully pulled the latest changes from $REPO_URL."

#do pre run configurations
echo "Installing dependencies..."
npm install
if [ $? -ne 0 ]; then
    echo "Dependency installation failed!"
    exit 1
fi
echo "Dependencies installed successfully."

#kill all othr node processes
echo "Stopping any running instance of the backend..."
pkill -f 'node' 
echo "Stopped any running backend instances."

#start a demonized backend using nohup and direct it's standard input and output to app.log
echo "Starting the backend..."
nohup node server.js > app.log 2>&1 &
if [ $? -ne 0 ]; then
    echo "Failed to start the backend!"
    exit 1
fi



echo "Deployment completed successfully!"

