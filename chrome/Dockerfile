#Testing webhook still
# Run Chrome in a container
# For Ubuntu I had to add download Jessie's chrome.json.
# wget wget https://raw.githubusercontent.com/jfrazelle/dotfiles/master/etc/docker/seccomp/chrome.json -o ~/chrome.json
# docker run \
#  --memory 512mb \
#  --net host \
#  -v /tmp/.X11-unix:/tmp/.X11-unix \
#  -e DISPLAY=$DISPLAY \
#  -v $HOME/Downloads:/home/chrome/Downloads \
#  -v $HOME/.config/google-chrome:/data \
#  -v /run/dbus/:/run/dbus/:rw \
#  -v /dev/shm:/dev/shm \
#  --device /dev/snd \
#  --security-opt seccomp:$HOME/chrome.json \
#  --name chrome aslaen/chrome \

# Base docker image
FROM debian:sid
MAINTAINER Jason Smith <jason@smithss.org>

ADD https://dl.google.com/linux/direct/google-talkplugin_current_amd64.deb /src/google-talkplugin_current_amd64.deb

# Install Chrome
RUN apt-get update && apt-get install -y \
	apt-transport-https \
	ca-certificates \
	curl \
	gnupg \
	hicolor-icon-theme \
	libgl1-mesa-dri \
	libgl1-mesa-glx \
	libpulse0 \
	libv4l-0 \
	fonts-symbola \
	--no-install-recommends \
	&& curl -sSL https://dl.google.com/linux/linux_signing_key.pub | apt-key add - \
	&& echo "deb [arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google.list \
	&& apt-get update && apt-get install -y \
	google-chrome-stable \
	--no-install-recommends \
	&& dpkg -i '/src/google-talkplugin_current_amd64.deb' \
	&& apt-get purge --auto-remove -y curl \
	&& rm -rf /var/lib/apt/lists/* \
	&& rm -rf /src/*.deb
RUN groupadd -r chrome && useradd -r -g chrome -G audio,video chrome \
    && mkdir -p /home/chrome/Downloads && chown -R chrome:chrome /home/chrome

COPY local.conf /etc/fonts/local.conf
# Run Chrome as non privileged user
USER chrome
# Autorun chrome
ENTRYPOINT [ "google-chrome" ]
CMD [ "--user-data-dir=/data" ]
