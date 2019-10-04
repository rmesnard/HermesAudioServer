# Hermes Audio Server Docker Image


A Docker Image to build a Hermes Audio Server to work with Snips or Rhasspy


Initial Project Here  :
https://pypi.org/project/hermes-audio-server/


Wiki :


#build

install git : 

sudo apt-get install git

Build with docker :

sudo docker build -t lijah/hermesaudioserver github.com/rmesnard/HermesAudioServer

complete rebuild :

sudo docker build --no-cache -t lijah/hermesaudioserver github.com/rmesnard/HermesAudioServer


#install


create volume :

sudo docker volume create hermes_config
sudo docker volume create hermes_log

sudo docker volume inspect hermes_config


#run 

sudo docker run -d --name hermesaudioserver \
-v hermes_log:/var/log \
-v hermes_config:/usr/share/hermes \
--privileged \
--device=/dev/snd:/dev/snd \
lijah/hermesaudioserver


#share config 


docker run -d -p 192.168.2.xxx:445:445 \
-v  hermes_config:/share/data \
-v  hermes_log:/share/log \
--name samba_snips trnape/rpi-samba \
-u "admin:<YOUR PASSWORD>" \
-s "hermes_config:/share/data:rw:admin" \
-s "hermes_log:/share/log:rw:admin" 

#console

sudo docker exec -it hermesaudioserver bash

cd /usr/share/hermes/config
