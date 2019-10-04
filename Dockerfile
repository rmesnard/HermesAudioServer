FROM raspbian/stretch

RUN set -x && \
	apt-get update && apt-get dist-upgrade -y
 
RUN set -x && \	
	apt-get install -y portaudio19-dev
	
#python libraries

RUN cd /opt && pip3 install hermes-audio-server 
	
COPY ./config/ /config/ 
COPY ./scripts/ /scripts/ 

COPY start.sh start.sh

EXPOSE 1833/tcp

CMD ["bash","/start.sh"]
