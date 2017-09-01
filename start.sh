#!/bin/sh


GENESIS64=e1xyXG4gICAgImNvbmZpZyI6IHtcclxuICAgICAgICAiY2hhaW5JZCI6IDIwMTcwOCxcclxuICAgICAgICAiaG9tZXN0ZWFkQmxvY2siOiAwLFxyXG4gICAgICAgICJlaXAxNTVCbG9jayI6IDAsXHJcbiAgICAgICAgImVpcDE1OEJsb2NrIjogMFxyXG4gICAgfSxcclxuICAgICJkaWZmaWN1bHR5IjogIjcwMDAwMCIsXHJcbiAgICAiZ2FzTGltaXQiOiAiMjEwMDAwMCIsXHJcbiAgICAiYWxsb2MiOiB7XHJcbiAgICAgICAgIjB4NmNhMzkzYWQ1ZThjMzBlMTRmNDBjOTFhZjc2YmY3ZDc5ZWJjYmNlMiI6IHtcclxuICAgICAgICAgICAgImJhbGFuY2UiOiAiMTAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMCJcclxuICAgICAgICB9LFxyXG4gICAgICAgICIweDlkYTczMzVmODlkZGY0MzUxNjAxMGVmZDZkZDhjYTVjYmQwMTIxZDIiOiB7XHJcbiAgICAgICAgICAgICJiYWxhbmNlIjogIjEwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAiXHJcbiAgICAgICAgfSxcclxuICAgICAgICAiMHhmYmY4MDViMWE4NzJlYTk0M2VhODJlZGZmOTI4ZDc4NDJiY2RkN2ZkIjoge1xyXG4gICAgICAgICAgICAiYmFsYW5jZSI6ICIxMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwIlxyXG4gICAgICAgIH1cclxuICAgIH1cclxufVxyXG4
GENESIS=$(echo $GENESIS64 | base64 --decode)
echo $GENESIS
echo $GENESIS > genesis.json
cat genesis.json
geth --datadir . init genesis.json

# DEFAULT_ARGS="--networkid $NETWORK_ID --bootnodes enode://$(bootnode -nodekeyhex $BOOTNODE_KEY -writeaddress)@$BOOTNODE_SERVICE_HOST:$BOOTNODE_SERVICE_PORT"

# geth $DEFAULT_ARGS $@

let objJsonB64 = new Buffer(JSON.stringify(require('./genesis'))).toString("base64")



# creates an nginx config for a local route
nginx_config(){
  server=$1
  route=$2

  cat >"${HOME}/.nginx/conf.d/${server}.conf" <<-EOF
  upstream ${server} { server ${route}; }
  server {
  server_name ${server};

  location / {
  proxy_pass  http://${server};
  proxy_http_version 1.1;
  proxy_set_header Upgrade \$http_upgrade;
  proxy_set_header Connection "upgrade";
  proxy_set_header Host \$http_host;
  proxy_set_header X-Forwarded-Proto \$scheme;
  proxy_set_header X-Forwarded-For \$remote_addr;
  proxy_set_header X-Forwarded-Port \$server_port;
  proxy_set_header X-Request-Start \$msec;
}
  }
  EOF
}
