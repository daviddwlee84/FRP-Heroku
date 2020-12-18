FROM alpine

RUN apk add --update tzdata

# https://www.gnu.org/software/libc/manual/html_node/TZ-Variable.html
ENV TZ=Asia/Taipei
ENV FRP_VERSION 0.33.0

# Setup FRP
RUN wget https://github.com/fatedier/frp/releases/download/v${FRP_VERSION}/frp_${FRP_VERSION}_linux_amd64.tar.gz \
    && tar -xf frp_${FRP_VERSION}_linux_amd64.tar.gz \
    && mkdir /frps \
    && cp frp_${FRP_VERSION}_linux_amd64/frps* /frps/ \
    && rm -rf frp_${FRP_VERSION}_linux_amd64*

# Clean APK cache
RUN rm -rf /var/cache/apk/*

# Add configuration files and scripts
ADD frps.ini /frps/frps.ini

CMD /frps/frps -c /frps/frps.ini