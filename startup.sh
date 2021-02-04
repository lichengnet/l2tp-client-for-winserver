#!/bin/sh

echo "startup/vpn: configuring vpn client."
# template out all the config files using env vars
sed -i 's/right=.*/right='$VPN_SERVER'/' /etc/ipsec.conf
echo ': PSK "'$VPN_PSK'"' > /etc/ipsec.secrets
sed -i 's/lns = .*/lns = '$VPN_SERVER'/' /etc/xl2tpd/xl2tpd.conf
sed -i 's/name .*/name '$VPN_USERNAME'/' /etc/ppp/options.l2tpd.client
sed -i 's/password .*/password '$VPN_PASSWORD'/' /etc/ppp/options.l2tpd.client

strongswan start

# startup xl2tpd ppp daemon then send it a connect command
(sleep 0 && echo "startup/vpn: send connect command to vpn client." ) \
&& exec /reconnector.sh &
echo "startup/vpn: start vpn client daemon."
exec /usr/sbin/xl2tpd -p /var/run/xl2tpd.pid -c /etc/xl2tpd/xl2tpd.conf -C /var/run/xl2tpd/l2tp-control -D &


exec tail -f /dev/null  ## %%LAST-CMD_2_REPLACE%

