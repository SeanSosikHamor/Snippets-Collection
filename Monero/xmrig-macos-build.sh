#!/bin/sh

brew install cmake libuv openssl hwloc wget automake libtool autoconf

git clone https://github.com/xmrig/xmrig.git
mkdir xmrig/build && cd xmrig/build
cmake .. -DOPENSSL_ROOT_DIR=/usr/local/opt/openssl
make -j$(sysctl -n hw.logicalcpu)
