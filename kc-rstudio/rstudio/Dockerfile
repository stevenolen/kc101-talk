FROM debian:latest
MAINTAINER Steve Nolen <technolengy@gmail.com>

ADD rstudio-server-pro-*-amd64.deb /tmp/rstudio-server.deb

RUN set -x \
    && export DEBIAN_FRONTEND=noninteractive \
    && echo 'deb http://cran.rstudio.com/bin/linux/debian jessie-cran3/' >> /etc/apt/sources.list \
    && apt-key adv --keyserver keys.gnupg.net --recv-key 381BA480 \
    && apt-get update \
    && apt-get install --no-install-recommends -y r-base gdebi-core sudo git curl libcurl4-openssl-dev ed  \
    && gdebi -n /tmp/rstudio-server.deb \
    && addgroup rstudio-users \
    && pam-auth-update --package \

    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD pam-rstudio /etc/pam.d/su
ADD pam_add_user.sh /usr/local/bin/pam_add_user.sh

ADD run.sh /run.sh
RUN chmod +x /run.sh
RUN chmod +x /usr/local/bin/pam_add_user.sh

RUN echo "auth-proxy=1\nauth-proxy-sign-in-url=http://example.com/sign-in\nserver-access-log=1" > /etc/rstudio/rserver.conf

EXPOSE 8787

CMD ["/run.sh"]