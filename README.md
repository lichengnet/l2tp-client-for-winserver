l2tp-client-for-winserver


An centos based docker image to setup an L2TP over IPsec VPN client w/ PSK for win l2tp server


## Run

run it (you can daemonize of course after debugging):
```bash
docker run --rm -it --name l2tp --privileged \
           -e VPN_SERVER=xx.xx.xx.xx \
           -e VPN_PSK=xxxxx \
           -e VPN_USERNAME=xxxxx \
           -e VPN_PASSWORD=xxxxxxx \
           -e VPN_ROUTE=192.168.2.0/24 \
l2tp
```
