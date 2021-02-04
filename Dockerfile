FROM centos:centos7.9.2009

RUN yum -y install epel-release net-tools \
    && yum --enablerepo=epel -y install strongswan xl2tpd \
    && yum -y install strongswan xl2tpd \
    && yum clean all \
    && mkdir -p /var/run/xl2tpd

# VPN Files
COPY ipsec.conf /etc/ipsec.conf
COPY ipsec.secrets /etc/ipsec.secrets
COPY xl2tpd.conf /etc/xl2tpd/xl2tpd.conf
COPY options.l2tpd.client /etc/ppp/options.l2tpd.client

# Scripts
RUN chmod 600 /etc/ipsec.secrets
RUN chmod 600 /etc/ppp/options.l2tpd.client
RUN mv /etc/strongswan/ipsec.conf /etc/strongswan/ipsec.conf.old 2>/dev/null
RUN mv /etc/strongswan/ipsec.secrets /etc/strongswan/ipsec.secrets.old 2>/dev/null
RUN ln -s /etc/ipsec.conf /etc/strongswan/ipsec.conf
RUN ln -s /etc/ipsec.secrets /etc/strongswan/ipsec.secrets
COPY startup.sh /
COPY reconnector.sh /

CMD ["/startup.sh"]
