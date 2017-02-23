#!/bin/bash 

### This wrapper script sets xhost and starts the chrome docker container.


xhost local:root > /dev/null

if [[ $(docker ps -a|grep chrome) ]]; then
    docker start chrome
else
    echo "Creating "Chrome" container"
    docker run --memory 512mb --net host -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$DISPLAY -v $HOME/Downloads:/home/chrome/Downloads -v $HOME/.config/google-chrome:/data -v /run/dbus/:/run/dbus/:rw -v /dev/shm:/dev/shm --device /dev/snd --security-opt seccomp:$HOME/chrome.json --name chrome aslaen/chrome --force-device-scale-factor=1 &> /dev/null
fi