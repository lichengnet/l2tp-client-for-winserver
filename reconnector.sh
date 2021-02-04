#!/bin/sh
while true; do
  if ! route | grep  ppp0 > /dev/null; then
    # strongswan down myvpn
    echo "reconnector: wait for 5 secs";sleep 5
    strongswan up myvpn
    # wait for 5 sec to make sure ppp0 is avalible again in case of diconnection
    # try to connect vpn if it's not connected
    xl2tpd-control -c /var/run/xl2tpd/l2tp-control connect 'myvpn'
    # Wait for vpn to create ppp0 network interface
    while ! route | grep ppp0 > /dev/null; do echo "reconnector: waiting for ppp0"; sleep 1; done

    #add route
    route add -net ${VPN_ROUTE} dev ppp0
    ifconfig |grep inet
    route
  else
    sleep 10
  fi
done