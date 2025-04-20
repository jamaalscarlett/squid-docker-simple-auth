FROM ubuntu:24.04

RUN apt-get -qqy update && \
  apt-get -qqy upgrade && \
  apt-get -qqy install apache2-utils squid 

RUN sed -i 's@##auth_param basic program <uncomment and complete this line>@auth_param basic program /usr/lib/squid/basic_ncsa_auth /usr/etc/passwd\nacl ncsa_users proxy_auth REQUIRED@' /etc/squid/squid.conf
RUN sed -i 's@http_access allow localhost$@http_access allow localhost\nhttp_access allow ncsa_users@' /etc/squid/squid.conf

EXPOSE 3128
VOLUME /var/log/squid

ADD init /init
CMD ["/init"]
