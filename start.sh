#!/bin/bash
set -e


echo "Install config."
if [ ! -d "/usr/share/hermes/config" ]; then
  echo "Install default config."
  mkdir /usr/share/hermes/config
  cp -R -f /config /usr/share/hermes
fi
chmod -R 777 /usr/share/hermes/config

rm -f /etc/asound.conf
cp -f /usr/share/hermes/config/asound.conf /etc/asound.conf


echo "Install scripts."
if [ ! -d "/usr/share/hermes/scripts" ]; then
  echo "Install default scripts."
  mkdir /usr/share/hermes/scripts
  cp -R -f /scripts /usr/share/hermes
fi
chmod -R 777 /usr/share/hermes/scripts

#go back to root directory
cd /

echo "Player "
hermes-audio-player --version
echo "Recorder "
hermes-audio-recorder --version

echo "Start server"

chmod -R 777 /var/log

hermes-audio-player --config /usr/share/hermes/config/hermes-audio-server.json 2> /var/log/audio-player.log &
audio_player_pid=$!

hermes-audio-recorder --config /usr/share/hermes/config/hermes-audio-server.json 2> /var/log/audio-recorder.log &
audio_recorder_pid=$!

echo "services started.. check logs"

wait "$audio_player_pid"

