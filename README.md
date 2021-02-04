l2tp-client-for-winserver


An centos based docker image to setup an L2TP over IPsec VPN client w/ PSK for win l2tp server


## Run

run it (you can daemonize of course after debugging):
```bash
docker run --rm -it --name l2tp --privileged \
           -e VPN_SERVER=180.166.2.1 \
           -e VPN_PSK=hongguaninfo \
           -e VPN_USERNAME=test \
           -e VPN_PASSWORD=Hg@123456 \
           -e VPN_ROUTE=192.168.2.0/24 \
l2tp
```
