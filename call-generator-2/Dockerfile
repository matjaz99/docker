FROM alpine:3.10.3

RUN apk --no-cache add bash \
 && echo "" > /root/.ash_history

# change default shell from ash to bash
RUN sed -i -e "s/bin\/ash/bin\/bash/" /etc/passwd

RUN apk --no-cache add curl

ENV LC_ALL=en_US.UTF-8

COPY generateCall2.sh /generateCall2.sh

CMD ["bash", "/generateCall2.sh"]