FROM ethereum/client-go:v1.6.1

RUN ln -s /geth /bin/geth

ADD keystore /root/.ethereum/keystore
ADD genesis.json /root/.ethereum
RUN geth init /root/.ethereum/genesis.json

EXPOSE 30305
EXPOSE 30305/udp
EXPOSE 8545

ENTRYPOINT ["geth"]
