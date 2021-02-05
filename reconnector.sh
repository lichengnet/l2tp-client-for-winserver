#!/bin/sh
while true; do
  if ! route | grep  ppp0 > /dev/null; then
    # strongswan down myvpn
    echo "connector: wait for 3 secs";sleep 3
    strongswan up myvpn
    # wait for 5 sec to make sure ppp0 is avalible again in case of diconnection
    # try to connect vpn if it's not connected
    xl2tpd-control -c /var/run/xl2tpd/l2tp-control connect 'myvpn'
    # Wait for vpn to create ppp0 network interface
    while ! route | grep ppp0 > /dev/null; do echo "checking: waiting for ppp0"; sleep 1; done

    #add route
    route add -net ${VPN_ROUTE} dev ppp0
    ifconfig |grep inet
    route

    ##restart socks5
    if [[ $SCOKS5_ENABLE -eq 1 ]];then
        # kill sockd
        echo "startup/socks5: waiting for ppp0"
      (while ! route | grep ppp0 > /dev/null; do sleep 1; done \
        && echo "startup/socks5: Socks5 will start in $SCOKS5_START_DELAY seconds" \
        && sleep $SCOKS5_START_DELAY \
        && sockd -N $SCOKS5_FORKS) &
    else
      echo "startup/socks5: Ignore socks5 server."
    fi
  else
    sleep 10
  fi
done