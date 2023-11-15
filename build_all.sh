#!/bin/sh

set -e

echo
echo "========================="
echo " Building Kaspad"
echo "========================="
echo
./karlsend/build.sh $@

echo
echo "========================="
echo " Building Loadbalancer"
echo "========================="
echo
./karlsend_loadbalancer/build.sh $@

#echo
#echo "========================="
#echo " Building Kaspawallet"
#echo "========================="
#echo
#./kaspawallet/build.sh $@

echo
echo "========================="
echo " Done"
echo "========================="
echo
