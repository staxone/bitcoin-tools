#!/bin/bash

####################################################################
# COPYRIGHT (c) 2022 by staxone (hello@staxone.com)
#
# Original Bitcoin Unix Build Documentation:
# https://github.com/bitcoin/bitcoin/blob/master/doc/build-unix.md
####################################################################

# Update/Upgrade System
sudo apt -qq update
sudo apt -qq upgrade -y

# Install needed packages
#sudo apt install build-essential libtool autotools-dev automake pkg-config bsdmainutils python3 -y
#sudo apt install libevent-dev libboost-dev libboost-system-dev libboost-filesystem-dev libboost-test-dev -y
#sudo apt install libsqlite3-dev -y
#sudo apt install libminiupnpc-dev libnatpmp-dev -y
#sudo apt install libzmq3-dev -y
#sudo apt install libqt5gui5 libqt5core5a libqt5dbus5 qttools5-dev qttools5-dev-tools -y
#sudo apt install libqrencode-dev -y
sudo apt -qq install git build-essential libtool autotools-dev automake pkg-config bsdmainutils python3 libqrencode-dev libqt5gui5 libqt5core5a libqt5dbus5 qttools5-dev qttools5-dev-tools libzmq3-dev libminiupnpc-dev libnatpmp-dev libsqlite3-dev libevent-dev libboost-dev libboost-system-dev libboost-filesystem-dev libboost-test-dev libboost-all-dev -y

# Clone Bitcoin 22.x repo
git clone https://github.com/bitcoin/bitcoin
cd bitcoin/
git checkout 22.x

# Berkeley DB 4.8 build
./contrib/install_db4.sh `pwd`

# Berkeley DB 4.8 configure for build 
export BDB_PREFIX=$(pwd)'/db4'

# Build Bitcoin
./autogen.sh
./configure BDB_LIBS="-L${BDB_PREFIX}/lib -ldb_cxx-4.8" BDB_CFLAGS="-I${BDB_PREFIX}/include"
#make # only one parrallel job? 
sudo make -j 2 # 2 parrallel jobs
sudo make install # optional